//
//  MockBreedImagesViewModel.swift
//  Paws
//
//  Created by Rodrigo Peña on 11/8/25.
//

import SwiftUI
internal import Combine

final class MockBreedImagesViewModel: BreedImagesViewModel {
    @Published var images: [URL] = (1...10).map { URL(string: "https://https://mock.com/dog/200/200?image=\($0)")! }
    
    @Published var isLoading: Bool = false
    var breed: String = "mock"
    func load() {}
}

#Preview {
    BreedImagesView(viewModel: MockBreedImagesViewModel())
}
