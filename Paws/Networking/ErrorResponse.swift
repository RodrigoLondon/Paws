//
//  ErrorResponse.swift
//  Paws
//
//  Created by Rodrigo Peña on 6/8/25.
//

import Foundation

struct ErrorResponse: Codable {
    let status: String
    let message: String?
}

enum NetworkError: Error {
    case badRequest
    case decodingError(Error)
    case invalidResponse
    case errorResponse(ErrorResponse)
}

extension NetworkError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .badRequest:
            return NSLocalizedString("Bad Request (400): Unable to perform the request.", comment: "badRequestError")
        case .decodingError(let error):
            return NSLocalizedString("Unable to decode successfully. \(error)", comment: "decodingError")
        case .invalidResponse:
            return NSLocalizedString("Invalid response.", comment: "invalidResponse")
        case .errorResponse(let errorResponse):
            return NSLocalizedString("Error \(errorResponse.message ?? "")", comment: "Error Response")
        }
    }
}
