//
//  DetailViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/06.
//

import SwiftUI
import Combine

class DetailViewModel: ObservableObject {
    @Published var contents: DetailModel?
    @Published var errorMessage: ErrorMessage?
    @Published var status: DetailScreenStatus = .loading
    @Published var showTrackingAlert = false
    @Published var inputPrice = ""
    @Published var isTracking = false

    private let networkService: NetworkServiceProtocol
    private let trackingInfoService: TrackingInfoServiceProtocol
    private let gameId: String
    private var cancellables = Set<AnyCancellable>()
    private let buttonTapped = PassthroughSubject<Void, Never>()

    @AppStorage("trackingInfos") private var storedTrackingInfoData: Data?

    init(
        networkService: NetworkServiceProtocol = NetworkService(),
        trackingInfoService: TrackingInfoServiceProtocol = TrackingInfoService(),
        gameId: String
    ) {
        self.networkService = networkService
        self.trackingInfoService = trackingInfoService
        self.gameId = gameId

        bindButtonAction()
    }

    private func bindButtonAction() {
        buttonTapped
            .sink { [weak self] in
                self?.handleButtonTap()
            }
            .store(in: &cancellables)
    }

    private func handleButtonTap() {
        showTrackingAlert = true
    }

    func getFormattedSavings(for item: Deal) -> String {
        let savings = item.doubledString(string: item.savings)
        let savingsText: String

        if savings < 1.0 {
            savingsText = NSLocalizedString("savings_none_string", comment: "savings rate less than 1%")
        } else {
            let savingsString = String(format: "%.2f", savings)
            savingsText = String(format: NSLocalizedString("savings_string", comment: "Savings format"), savingsString)
        }

        return savingsText
    }

    func getPrice(for item: Deal) -> String {
        String(format: NSLocalizedString("price_string", comment: "Price format"), item.price)
    }

    func fetchDetail() {
        status = .loading
        Task {
            do {
                let gameDetail = try await self.networkService.fetchGameDetail(gameId: gameId)
                let sortedDeals = gameDetail.deals.sorted {
                    Double($0.price) ?? 0 < Double($1.price) ?? 0
                }
                await MainActor.run {
                    updateDetailSucessStatus(items: gameDetail, sortedDeals: sortedDeals)
                }
            } catch {
                await MainActor.run {
                    updateErrorStatus(error: error)
                }
            }
        }
    }

    @MainActor
    private func updateErrorStatus(error: Error) {
        let localizedMessage = String(
            format: NSLocalizedString("detail_error_message",
            comment: "error occurred while loading detail"), "\(error)")
        errorMessage = ErrorMessage(message: localizedMessage)
    }

    @MainActor
    private func updateDetailSucessStatus(items: DetailModel, sortedDeals: [Deal]) {
        status = .success(items: items, sortedDeals: sortedDeals)
        self.contents = items
        errorMessage = nil
    }

    func onTrackingButtonTapped() {
        buttonTapped.send()
    }

    func validatePriceInput(_ input: String) -> String? {
        guard let price = Double(input), price > 0 else {
            return nil
        }
        return String(price)
    }

    func onPriceInputConfirmed() {
        guard let price = validatePriceInput(inputPrice) else {
            print("invalid input price")
            return
        }

        let newTrackingInfo = TrackingInfo(
            title: contents?.info.title ?? "",
            userPrice: price,
            thumb: contents?.info.thumb ?? ""
        )

        var trackingInfos = loadTrackingInfos() ?? []
        trackingInfos.append(newTrackingInfo)

        saveTrackingInfos(trackingInfos)

        isTracking = true
        showTrackingAlert = false
        printSavedTrackingInfos()
    }

    func onPriceInputCancelled() {
        showTrackingAlert = false
        inputPrice = ""
    }

    func saveTrackingInfos(_ trackingInfos: [TrackingInfo]) {
        trackingInfoService.saveTrackingInfos(trackingInfos)
    }

    func loadTrackingInfos() -> [TrackingInfo]? {
        let result = trackingInfoService.loadTrackingInfos()

        switch result {
        case .success(let trackingInfos):
            return trackingInfos
        case .failure(let error):
            print("Failed to load tracking infos: \(error.localizedDescription)")
            return nil
        }
    }


#if DEBUG
    func printSavedTrackingInfos() {
        if let trackingInfos = loadTrackingInfos() {
            for info in trackingInfos {
                print("Tracking Info:")
                print("UUID: \(info.id)")
                print("Title: \(info.title)")
                print("User Price: \(info.userPrice ?? "N/A")")
                print("Thumbnail: \(info.thumb)")
                print("----------------------")
            }
        } else {
            print("No tracking infos saved.")
        }
    }
#endif
}
