//
//  Endpoint.swift
//  Paws
//
//  Created by Rodrigo Peña on 6/8/25.
//

import Foundation

enum Endpoint {
    case breeds
    case breedImages(breed: String, numberOfImages: Int)

    var url: URL {
        let base = "https://dog.ceo/api"

        switch self {
        case .breeds: //https://dog.ceo/api/breeds/list/all
            return URL(string: "\(base)/breeds/list/all")!
        case .breedImages(let breed, let numberOfImages):
            // Normalize breed format: "hound afghan" → "hound/afghan"
            let parts = breed.split(separator: " ").map(String.init)
            let formattedBreed = parts.reversed().joined(separator: "/")
           return URL(string: "\(base)/breed/\(formattedBreed)/images/random/\(numberOfImages)")!
        }
    }
}
