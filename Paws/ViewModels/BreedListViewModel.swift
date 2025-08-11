//
//  BreedListViewModel.swift
//  Paws
//
//  Created by Rodrigo Peña on 3/8/25.
//

import SwiftUI
internal import Combine

// MARK: - BreedList ViewModel

protocol BreedListViewModel: ObservableObject {
    var breeds: [String] { get }
    var isLoading: Bool { get }
    func load()
}

@MainActor
final class BreedListViewModelImpl: BreedListViewModel {
    @Published private(set) var breeds: [String] = []
    @Published private(set) var isLoading = false

    private let service: DogService

    init(service: DogService) {
        self.service = service
    }

    func load() {
        isLoading = true
        Task {
            do {
                breeds = try await service.fetchBreeds()
            } catch {
                breeds = []
            }
            isLoading = false
        }
    }
}
