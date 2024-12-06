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
    private let gameId: String
    private var cancellables = Set<AnyCancellable>()
    private let buttonTapped = PassthroughSubject<Void, Never>()

    @AppStorage("trackingInfos") private var storedTrackingInfoData: Data?

    init(
        networkService: NetworkServiceProtocol = NetworkService(),
        gameId: String
    ) {
        self.networkService = networkService
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
            savingsText = "Savings: None"
        } else {
            savingsText = "Saving: \(String(format: "%.2f", savings))%"
        }

        return savingsText
    }

    func getPrice(for item: Deal) -> String {
        "Price: $\(item.price)"
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
                    status = .success(items: gameDetail, sortedDeals: sortedDeals)
                    self.contents = gameDetail
                    errorMessage = nil
                }
            } catch {
                await MainActor.run {
                    status = .error
                    let localizedMessage = String(
                        format: NSLocalizedString("detail_error_message",
                                                  comment: "error occurred while loading detail"), "\(error)")
                    errorMessage = ErrorMessage(message: localizedMessage)
                }
            }
        }
    }

    func onTrackingButtonTapped() {
        buttonTapped.send()
    }

    func onPriceInputConfirmed() {
        if let price = Double(inputPrice), price > 0 {
            let newTrackingInfo = TrackingInfo(
                uuidString: UUID().uuidString,
                title: contents?.info.title ?? "",
                userPrice: inputPrice,
                thumb: contents?.info.thumb ?? ""
            )

            var trackingInfos = loadTrackingInfos() ?? []
            trackingInfos.append(newTrackingInfo)

            saveTrackingInfos(trackingInfos)

            isTracking = true
            showTrackingAlert = false
            printSavedTrackingInfos()
        } else {
            print("Invalid price input")
        }
    }

    func onPriceInputCancelled() {
        showTrackingAlert = false
        inputPrice = ""
    }

    func saveTrackingInfos(_ trackingInfos: [TrackingInfo]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(trackingInfos)
            storedTrackingInfoData = data
        } catch {
            print("Failed to encode TrackingInfos: \(error)")
        }
    }

    func loadTrackingInfos() -> [TrackingInfo]? {
        guard let data = storedTrackingInfoData else { return nil }
        do {
            let decoder = JSONDecoder()
            let trackingInfos = try decoder.decode([TrackingInfo].self, from: data)
            return trackingInfos
        } catch {
            print("Failed to decode TrackingInfos: \(error)")
            return nil
        }
    }

    func printSavedTrackingInfos() {
        if let trackingInfos = loadTrackingInfos() {
            for info in trackingInfos {
                print("Tracking Info:")
                print("UUID: \(info.uuidString)")
                print("Title: \(info.title)")
                print("User Price: \(info.userPrice ?? "N/A")")
                print("Thumbnail: \(info.thumb)")
                print("----------------------")
            }
        } else {
            print("No tracking infos saved.")
        }
    }
}
