//
//  RootCoordinatorView.swift
//  Paws
//
//  Created by Rodrigo Peña on 3/8/25.
//

import Foundation
import SwiftUI

struct RootCoordinatorView<CoordinatorType: Coordinator>: View {    
    @ObservedObject private var coordinator: CoordinatorType
    
    init(coordinator: CoordinatorType) {
        self.coordinator = coordinator
    }

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            coordinator.makeStartView()
                .navigationDestination(for: CoordinatorRoute.self) { route in
                    coordinator.view(for: route)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.view(for: sheet.route)
                }
                .fullScreenCover(item: $coordinator.fullScreenCover) { cover in
                    coordinator.view(for: cover.route)
                }
        }
    }
}

// MARK: - Supporting Types for Sheet & Cover

extension RootCoordinatorView {
    
    struct Sheet: Identifiable, Equatable {
        let id = UUID()
        let route: CoordinatorRoute
    }

    struct FullScreenCover: Identifiable, Equatable {
        let id = UUID()
        let route: CoordinatorRoute
    }
}

#Preview("Mock Coordinator") {
    RootCoordinatorView(coordinator: MockCoordinator())
}

#Preview("BreedListCoordinator") {
    RootCoordinatorView(coordinator: BreedListCoordinator())
}
