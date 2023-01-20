//
//  NetworkService.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2023/01/19.
//

import UIKit
import Alamofire
import AlamofireImage

class NetworkService {
    
    var title = ""
    
    func fetchGameAPI(completion: @escaping(Result<[SearchGameList], Error>) -> Void) {
        let url = "https://www.cheapshark.com/api/1.0/games?"
        let param = [
            "title": title
        ]
        AF.request(url, method: .get, parameters: param)
            .responseData { response in
//                print("\(response.response)")
//                print("\(response.result)")
                switch response.result {
                case let .success(data):
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode([SearchGameList].self, from: data)
                        print("result - ", result)
                        completion(.success(result))
                    } catch {
                        completion(.failure(error))
                    }
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
}


