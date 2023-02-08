//
//  Image.swift
//  ImageSearch
//
//  Created by Алексей on 06.02.2023.
//

import Foundation

struct Image: Codable {
    let imageResults: [ImagesResult]
    
    enum CodingKeys: String, CodingKey {
        case imageResults = "images_results"
    }
}

struct ImagesResult: Codable {
    let thumbnail: String
    let link: String
    let original: String
}
