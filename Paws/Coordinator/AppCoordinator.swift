//
//  AppCoordinator.swift
//  Paws
//
//  Created by Rodrigo Peña on 7/8/25.
//

import Foundation
import SwiftUI

// AppCoordinator.swift
// Base coordinator with push/pop/sheet/cover support
// MARK: - Navigation Targets

enum CoordinatorRoute: Hashable {
    case breedImages(breed: String)
    case mockSheet
    case mockFullScreen
}

//Example Extra Routes for Expanding Functionality and Testing
struct Sheet: Identifiable {
    let id = UUID()
    let route: CoordinatorRoute
}

struct FullScreenCover: Identifiable {
    let id = UUID()
    let route: CoordinatorRoute
}

// MARK: - Coordinator Protocol

protocol Coordinator: ObservableObject {
    var navigationPath: NavigationPath { get set }
    var sheet: Sheet? { get set }
    var fullScreenCover: FullScreenCover? { get set }

    func push(_ route: CoordinatorRoute)
    func pop()
    func popToRoot()

    func presentSheet(_ sheet: Sheet)
    func dismissSheet()

    func presentFullScreenCover(_ cover: FullScreenCover)
    func dismissFullScreenCover()

    func view(for route: CoordinatorRoute) -> AnyView
    func makeStartView() -> AnyView
}

// MARK: - BaseCoordinator Default Implementation

extension Coordinator {
    func push(_ route: CoordinatorRoute) {
        navigationPath.append(route)
    }

    func pop() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }

    func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }

    func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }

    func dismissSheet() {
        self.sheet = nil
    }

    func presentFullScreenCover(_ cover: FullScreenCover) {
        self.fullScreenCover = cover
    }

    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
}
