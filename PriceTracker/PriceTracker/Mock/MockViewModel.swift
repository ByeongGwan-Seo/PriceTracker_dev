//
//  MockViewModel.swift
//  PriceTracker
//
//  Created by jaeeun on 2024/11/23.
//

class MockViewModel: SearchViewModelProtocol {
    var contents: [GameTitle]
    var status: SearchScreenStatus
    var errorMessage: ErrorMessage?
    
    init(
        contents: [GameTitle],
        status: SearchScreenStatus,
        errorMessage: ErrorMessage? = nil
    ) {
        self.contents = contents
        self.status = status
        self.errorMessage = errorMessage
    }
    
    func fetchGameList() {}
    func setSearchText(text: String) {}
}
