//
//  ImageResponse.swift
//  Paws
//
//  Created by Rodrigo Peña on 3/8/25.
//

import Foundation

struct ImageResponse: Decodable {
    let message: [String]
    let status: String
}
