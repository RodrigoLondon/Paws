//
//  MockCoordinator.swift
//  Paws
//
//  Created by Rodrigo Peña on 11/8/25.
//

import SwiftUI
internal import Combine

// MARK: - Mock Types for Testing/Previews

final class MockCoordinator: Coordinator {
    @Published var navigationPath = NavigationPath()
    @Published var sheet: Sheet? = nil
    @Published var fullScreenCover: FullScreenCover? = nil
    
    func makeStartView() -> AnyView {
        AnyView(
            VStack(spacing: 20) {
                Text("Mock Start View")
                Button("Push Detail") {
                    self.navigationPath.append(CoordinatorRoute.breedImages(breed: "akita"))
                }
                Button("Present Sheet") {
                    self.sheet = Sheet(route: .mockSheet)
                }
                Button("Present Full Screen Cover") {
                    self.fullScreenCover = FullScreenCover(route: .mockFullScreen)
                }
            }
                .padding()
        )
    }
    
    func view(for route: CoordinatorRoute) -> AnyView {
        switch route {
        case .breedImages(let breed):
            return AnyView(Text("Mock Breed Images for \(breed)"))
        case .mockSheet:
            return AnyView(
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.dismissSheet()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundColor(.blue)
                        }
                        .padding()
                    }
                    Spacer()
                    PawView()
                    Text("Mock Sheet Content")
                    Spacer()
                }
            )
        case .mockFullScreen:
            return AnyView(
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.dismissFullScreenCover()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundColor(.blue)
                        }
                        .padding()
                    }
                    Spacer()
                    PawView()
                    Text("Mock Full Screen Cover")
                    Spacer()
                }
                    .containerRelativeFrame([.horizontal, .vertical])
                    .background(Color.white)
            )
        }
    }
}
