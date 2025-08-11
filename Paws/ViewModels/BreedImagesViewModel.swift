//
//  BreedImagesViewModel.swift
//  Paws
//
//  Created by Rodrigo Peña on 3/8/25.
//

import SwiftUI
internal import Combine

protocol BreedImagesViewModel: ObservableObject {
    var images: [URL] { get }
    var isLoading: Bool { get }
    var breed: String { get }
    func load()
}

@MainActor
final class BreedImagesViewModelImpl: BreedImagesViewModel {
    @Published private(set) var images: [URL] = []
    @Published private(set) var isLoading = false
    let breed: String

    private let service: DogService

    init(breed: String, service: DogService) {
        self.breed = breed
        self.service = service
    }

    func load() {
        isLoading = true
        Task {
            do {
                images = try await service.fetchImages(for: breed, count: 10)
            } catch {
                images = []
            }
            isLoading = false
        }
    }
}
