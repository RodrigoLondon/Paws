//
//  MockBreedListViewModel.swift
//  Paws
//
//  Created by Rodrigo Peña on 11/8/25.
//

import SwiftUI
internal import Combine

final class MockBreedListViewModel: BreedListViewModel {
    @Published var breeds: [String] = ["beagle", "husky", "akita"]
    @Published var isLoading: Bool = false
    func load() {}
}

#Preview {
    BreedListView(viewModel: MockBreedListViewModel()) { breed in
        print("Tapped on \(breed)")
    }
}
