Paws 🐶
Explore dog breeds and their images from Dog CEO API.
A modular, scalable SwiftUI application using MVVM-C, Swift Concurrency, and robust architecture principles to showcase clean, testable, and maintainable code that can be expanded over time. The architecture is designed for modularity, scalability, and a clear separation of concerns.


🧠 Architecture: MVVM-C

Architecture – MVVM-C
* Model – Encapsulates API responses and domain models.
* View – SwiftUI UI components displaying data.
* ViewModel – Business logic, state management, communicates with the service layer.
* Coordinator – Handles navigation and routing logic independent of view models.
This structure was chosen to:
* Isolate navigation from business logic for easier testing and maintenance.
* Simplify expansion with new screens and flows.
* Keep code clean and aligned with SOLID principles.

We use MVVM-C (Model-View-ViewModel-Coordinator) to:
* Decouple UI, business logic, and navigation
* Enable reusability, testability, and separation of concerns
* Allow for coordinated multi-screen navigation using SwiftUI's NavigationStack
Layer	Responsibilities
Model	Data structures, Decodable types from API
View	UI layer using SwiftUI, stateless and reactive
ViewModel	Business logic, binds model to view, async handling
Coordinator	Manages navigation flow and screen transitions

💡 Design Patterns

✅ Creational
* Factory Method: Coordinators instantiate ViewModels and Views
* Singleton (optional): URLSession.shared is the system singleton
* Dependency Injection: ViewModels/services receive dependencies via initialisers. Injecting services and coordinators into views for testability.
* Builder (implicit): Endpoint enum constructs URLs cleanly

✅ Structural
* Facade: DogServiceImpl hides networking logic behind protocol
* Coordinator Pattern – Centralized navigation management with support for push, pop, sheets, and full-screen covers.
* Protocol-Oriented Design – Coordinators, ViewModels, and Services defined by protocols for flexibility.
* Adapter: Breed + SubBreed formatting into API-compatible URLs
* Composite: SwiftUI’s LazyVGrid composes multiple image cells

✅ Behavioral
* Observer: SwiftUI's @Published, @StateObject, @ObservedObject. @Published state in ViewModels and Coordinators for SwiftUI reactivity.
* Strategy: Service swapping via DogService protocol for testing/mocks
* Command Pattern – Coordinator methods (push, pop, presentSheet, dismiss) act as navigation commands.

✅ SOLID Principles
* S: Single Responsibility → Clear separation per layer
* O: Open/Closed → Easy to extend via new ViewModels or Coordinators
* L: Liskov Substitution → DogService allows mocking
* I: Interface Segregation → Specific protocols for DogService, etc.
* D: Dependency Inversion → ViewModels depend on abstract services

Other Principles
* DRY: Extracted generic fetch<T: Decodable>() for API calls
* KISS: Simple view layout & modular logic

🧪 Testing
* Swift Testing Framework used (@Test, #expect) with async
* Mock service for predictable test data and error simulation
* Unit tests for both BreedListViewModel and BreedImagesViewModel
* View previews with mocked models

🔁 Dependency Injection
Injected via initializer:
* DogService into BreedListViewModelImpl, BreedImagesViewModelImpl
* Enables clean unit testing and service swapping

🔧 Improvements (Future Work)
🧠 Performance
* Cache breed list and images to minimise network calls (URLCache or NSCache)
* Store fetched breed list locally in-memory + disk persistence (UserDefaults, CoreData)

📦 Data
* Use local JSON file as offline fallback
* Implement pagination for breed images.
* Implement persistence layer (e.g. Realm, Core Data, SQLite, Swift Data)

🚀 UX Enhancements
* Pagination for breed image loading
* Loading state indicators for all network requests
* Offline mode with cached data
* Swipe/Pinch-to-zoom on images
* Image detail modal with sharing/download option
* Error overlay (instead of silent fail)

🧪 Testing
* Snapshot tests
* UI tests (tap image → zoom → close)
* Performance tests for slow network simulation
* Expand UI tests for all navigation scenarios.
* Add integration tests for coordinator logic

📦 Tools & Tech
* SwiftUI
* Swift 5.9+
* Swift Testing Framework
* MVVM-C Pattern
* Async/Await
* Dependency Injection
* Dog CEO API

📁 Structure
├── Models
├── Views
├── ViewModels
├── Coordinators
├── Services
├── Previews + Mocks
├── Tests

👏 Credits
* Dog CEO API - https://dog.ceo/dog-api/   🧑‍💻🐾


Recent Enhancements
* Coordinator Upgrades:
    * Added push, pop, popToRoot, presentSheet, presentFullScreenCover, dismissSheet, and dismissCover.
    * Enables more complex and scalable navigation flows.
* RootCoordinatorView:
    * Supports navigation stack + sheets + full-screen covers.
    * Dependency injection for swapping coordinators (live or mock) in previews/tests.
    * Example routes for sheets and full-screen covers to validate navigation.
* Service Layer Refactor:
    * DRY networking logic to avoid duplication.
    * Reusable JSON decoding and error handling.
* Testability Improvements:
    * Mock coordinators and mock services for SwiftUI previews and UI tests.


Dependency Injection
* Injected coordinators and services into Views and ViewModels.
* Facilitates:
    * Unit testing with mocks.
    * Previews with mock data.
    * Easy swap between real and mock implementations.

Coordinator Pattern – Navigation Flow
The Coordinator centralizes all navigation logic so ViewModels remain focused solely on state and business logic. This makes it easier to maintain, extend, and test navigation independently from other parts of the app.
Navigation Capabilities Implemented
* Push – Add a new route to the navigation stack.
* Pop – Remove the last route from the stack.
* Pop to Root – Clear all routes to return to the first view.
* Present Sheet – Display a modal sheet.
* Present Full-Screen Cover – Display a full-screen modal.
* Dismiss Sheet / Dismiss Cover – Close the respective presentation

  

Diagram – Coordinator Navigation Flow

+------------------------+
|  Coordinator (Protocol)|
+------------------------+
        |
        v
+---------------------------+
| BreedListCoordinator      |
|---------------------------|
| - navigationPath          |------> Push ---> [Navigation Stack]
| - sheet                   |------> PresentSheet ---> [Modal Sheet]
| - fullScreenCover         |------> PresentFullScreenCover ---> [Full Screen Modal]
+---------------------------+
        ^                               ^
        |                               |
  ViewModels trigger             UI state changes
  navigation via closures        observed by RootCoordinatorView



Flow:
1. View triggers navigation via closure or binding to Coordinator.
2. Coordinator updates state (navigationPath, sheet, or fullScreenCover).
3. RootCoordinatorView observes state changes and updates the SwiftUI navigation stack or modals.
4. UI Tests can directly validate navigation commands without relying on full user flows.


Diagram – Coordinator Navigation Flow

classDiagram
    class Coordinator {
        <<protocol>>
        navigationPath : NavigationPath
        sheet : Sheet?
        fullScreenCover : FullScreenCover?
        +view(for route: CoordinatorRoute) AnyView
        +makeStartView() AnyView
        +push(route: CoordinatorRoute)
        +pop()
        +popToRoot()
        +presentSheet(sheet: Sheet)
        +presentFullScreenCover(cover: FullScreenCover)
        +dismissSheet()
        +dismissCover()
    }

    class BreedListCoordinator {
        navigationPath : NavigationPath
        sheet : Sheet?
        fullScreenCover : FullScreenCover?
    }

    class RootCoordinatorView {
        NavigationStack
        sheetPresentation
        fullScreenCoverPresentation
    }

    Coordinator <|-- BreedListCoordinator
    RootCoordinatorView --> Coordinator


Sequence Diagram – Push, Pop, Sheet, Cover

sequenceDiagram
    participant User
    participant ViewModel
    participant Coordinator
    participant RootCoordinatorView

    User->>ViewModel: taps item
    ViewModel->>Coordinator: push(route)
    Coordinator->>RootCoordinatorView: update navigationPath
    RootCoordinatorView-->>User: shows new pushed view

    User->>ViewModel: taps back
    ViewModel->>Coordinator: pop()
    Coordinator->>RootCoordinatorView: update navigationPath
    RootCoordinatorView-->>User: returns to previous view

    User->>ViewModel: taps "Show Sheet"
    ViewModel->>Coordinator: presentSheet(sheetType)
    Coordinator->>RootCoordinatorView: update sheet
    RootCoordinatorView-->>User: presents modal sheet

    User->>ViewModel: taps "Show Full Screen"
    ViewModel->>Coordinator: presentFullScreenCover(coverType)
    Coordinator->>RootCoordinatorView: update fullScreenCover
    RootCoordinatorView-->>User: presents full-screen modal


This makes the navigation lifecycle completely transparent, testable, and easy to extend when new flows are added.
