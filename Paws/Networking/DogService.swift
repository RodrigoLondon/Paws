//
//  DogService.swift
//  Paws
//
//  Created by Rodrigo Peña on 3/8/25.
//

import Foundation

// MARK: - Service Protocol

protocol DogService {
    func fetchBreeds() async throws -> [String]
    func fetchImages(for breed: String, count: Int) async throws -> [URL]
}


// MARK: - Service Implementation

final class DogServiceImpl: DogService {
    
    func fetchBreeds() async throws -> [String] {
        let response: BreedResponse = try await fetch(from: Endpoint.breeds.url)
        return response.message.flatMap { breed, subs in
            subs.isEmpty ? [breed] : subs.map { "\($0) \(breed)" }
        }.sorted()
    }

    func fetchImages(for breed: String, count: Int) async throws -> [URL] {
        let response: ImageResponse = try await fetch(from: Endpoint.breedImages(breed: breed, numberOfImages: count).url)
        return response.message.compactMap(URL.init(string:))
    }

    private func fetch<T: Decodable>(from url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200...299:
            break
        default:
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw NetworkError.errorResponse(errorResponse)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
