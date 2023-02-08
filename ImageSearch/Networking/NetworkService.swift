//
//  NetworkService.swift
//  ImageSearch
//
//  Created by Алексей on 06.02.2023.
//

import Foundation

class NetworkService {
    
    func request(query: String, complition: @escaping ((Result<Data, Error>) -> Void)) {
        
        let baseURL = "https://serpapi.com"
        let endpoint = "/search.json"
        
        var components = URLComponents(string: baseURL)!
        components.path = endpoint
        components.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "tbm", value: "isch"),
            URLQueryItem(name: "engine", value: "google"),
            URLQueryItem(name: "api_key", value: "ba2be5f1e1111f8e964159b3a6e261dce7245018a6940f9840dd40eb026ab9f4")
        ]
        
        guard let url = components.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    complition(.failure(error))
                    return
                }
                guard let data = data else { return }
                complition(.success(data))
            }
        }.resume()
    }
}

