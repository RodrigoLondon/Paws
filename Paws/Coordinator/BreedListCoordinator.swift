//
//  BreedListCoordinator.swift
//  Paws
//
//  Created by Rodrigo Peña on 3/8/25.
//

import Foundation
import SwiftUI
internal import Combine

// Coordinator implementation using push/pop/sheet abstraction
final class BreedListCoordinator: Coordinator {
    @Published var navigationPath = NavigationPath()
    @Published var sheet: Sheet? = nil
    @Published var fullScreenCover: FullScreenCover? = nil

    func makeStartView() -> AnyView {
        let viewModel = BreedListViewModelImpl(service: DogServiceImpl())
        return AnyView(
            BreedListView(viewModel: viewModel, onBreedTap: { [weak self] breed in
                self?.push(.breedImages(breed: breed))
            })
        )
    }

    func view(for route: CoordinatorRoute) -> AnyView {
        switch route {
        case .breedImages(let breed):
            let viewModel = BreedImagesViewModelImpl(breed: breed, service: DogServiceImpl())
            return AnyView(BreedImagesView(viewModel: viewModel))
        case .mockSheet:
            return AnyView(
                VStack {
                    PawView()
                    Text("Mock Sheet Content")
                }
            )
        case .mockFullScreen:
            return AnyView(
                VStack {
                    PawView()
                    Text("Mock Full Screen Cover")
                }
            )
        }
    }
}
