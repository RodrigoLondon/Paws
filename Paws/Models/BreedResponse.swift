//
//  BreedResponse.swift
//  Paws
//
//  Created by Rodrigo Peña on 3/8/25.
//

import Foundation

struct BreedResponse: Codable {
    let message: [String: [String]]
    let status: String
}

