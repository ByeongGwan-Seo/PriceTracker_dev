//
//  DetailMockViewModel.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/11/24.
//

class DetailMockViewModel: DetailViewModelProtocol {
    var contents: DetailModel?
    var errorMessage: ErrorMessage?
    var status: DetailScreenStatus
    
    init(
        contents: DetailModel,
        errorMessage: ErrorMessage? = nil,
        status: DetailScreenStatus
    ) {
        self.contents = contents
        self.errorMessage = errorMessage
        self.status = status
    }
    
    func fetchDetail() {}
}

func makeMockDetailModel() -> DetailModel {
    return DetailModel(
        info: Info(
            title: "test game",
            steamAppID: "123",
            thumb: "thumb1"
        ),
        cheapestPriceEver: CheapestPriceEver(
            price: "1.11",
            date: 20231124
        ),
        deals: [
            Deal(
                storeID: "123",
                dealID: "123",
                price: "123",
                retailPrice: "123",
                userPrice: nil,
                savings: "2"
            ),
            Deal(
                storeID: "456",
                dealID: "456",
                price: "456",
                retailPrice: "456",
                userPrice: nil,
                savings: "3"
            )
        ]
    )
}

@MainActor
func makeMockDetailViewModel() -> DetailMockViewModel {
    return DetailMockViewModel(
        contents: makeMockDetailModel(),
        errorMessage: nil,
        status: 
                .success(
                    items: makeMockDetailModel(),
                    sortedDeals: makeMockDetailModel().deals
                )
    )
}
