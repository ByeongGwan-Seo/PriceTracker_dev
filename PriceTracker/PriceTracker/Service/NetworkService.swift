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
    var id = ""
    
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
    
    func fetchDetail(completion: @escaping(Result<DetailModel, Error>) -> Void) {
        let url = "https://www.cheapshark.com/api/1.0/games?"
        let param = [
            "id": id
        ]
        AF.request(url, method: .get, parameters: param)
            .responseData { response in
                switch response.result {
                case let .success(data):
                    
//                    do {
//                        // make sure this JSON is in the format we expect
//                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                            // try to read out a string array
//                            print("json - ", json)
//                        }
//                    } catch let error as NSError {
//                        print("Failed to load: \(error.localizedDescription)")
//                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(DetailModel.self, from: data)
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


