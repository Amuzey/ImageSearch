//
//  NetworkDataFetcher.swift
//  ImageSearch
//
//  Created by Алексей on 08.02.2023.
//

import Foundation

final class NetworkDataFetcher {
    
   private let networkService = NetworkService()
    
    func fetchImage(query: String, response: @escaping (Result<Image, Error>) -> Void) {
        networkService.request(query: query) { result in
            switch result {
                
            case .success(let data):
                do {
                    let images = try JSONDecoder().decode(Image.self, from: data)
                    response(.success(images))
                } catch let jsonError {
                    print("Error to decode JSON", jsonError.localizedDescription)
                    response(.failure(jsonError))
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                             response(.failure(error))
            }
        }
    }
}
