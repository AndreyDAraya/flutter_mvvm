# Flutter MVVM News App

A modern Flutter application showcasing the MVVM (Model-View-ViewModel) architecture pattern with clean code principles. This app fetches and displays tech news in a vintage newspaper style interface.

## Architecture Overview

This project implements the MVVM (Model-View-ViewModel) architecture pattern, which provides a clean separation of concerns:

### Model

- Represents the data and business logic
- Located in `lib/features/*/domain/models`
- Uses Freezed for immutable data classes
- Handles data validation and transformation

### View

- UI layer that displays data to users
- Located in `lib/features/*/presentation/views`
- Stateless where possible for better performance
- Uses Riverpod Consumer widgets to observe ViewModels
- Implements responsive and adaptive designs

### ViewModel

- Manages UI state and business logic
- Located in `lib/features/*/presentation/viewmodels`
- Uses Riverpod for state management
- Handles data operations and transformations
- Provides UI-ready data to Views

## Key Features

- **State Management**: Riverpod 2.4.9 for reactive and testable state management
- **Navigation**: go_router 13.0.1 for declarative routing
- **API Integration**: Dio for HTTP networking with interceptors
- **Code Generation**:
  - Freezed for immutable models
  - JSON serialization
  - Riverpod generators
- **Performance Optimizations**:
  - Efficient color operations with withAlpha
  - Lazy loading and pagination
  - Shimmer loading effects
- **Modern UI**:
  - Vintage newspaper design
  - Custom Google Fonts
  - Responsive layouts
  - Smooth animations

## Project Structure

```
lib/
├── core/                   # Core functionality and utilities
│   ├── api/               # API client and response handling
│   ├── theme/             # App theme and styling
│   └── widgets/           # Reusable widgets
│
└── features/              # Feature modules
    └── news/             # News feature
        ├── data/         # Data layer (repositories)
        ├── domain/       # Business logic and models
        └── presentation/ # UI layer
            ├── viewmodels/
            └── views/
```

## Dependencies

```yaml
dependencies:
  flutter_riverpod: ^2.4.9
  riverpod_annotation: ^2.3.3
  go_router: ^13.0.1
  google_fonts: ^6.1.0
  shimmer: ^3.0.0
  url_launcher: ^6.2.2
  dio: ^5.4.0
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1

dev_dependencies:
  build_runner: ^2.4.7
  freezed: ^2.4.6
  json_serializable: ^6.7.1
  riverpod_generator: ^2.3.9
```

## Getting Started

1. Clone the repository

```bash
git clone https://github.com/AndreyDAraya/flutter_mvvm.git
```

2. Install dependencies

```bash
flutter pub get
```

3. Run code generation

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Run the app

```bash
flutter run
```

## Architecture Details

### Data Flow

1. Views observe ViewModels using Riverpod providers
2. ViewModels handle business logic and data operations
3. Models represent the data structure and validation
4. Repositories handle data fetching and caching
5. API client manages network requests

### Key Design Decisions

- **Feature-First Structure**: Organized by feature for better scalability
- **Clean Architecture Principles**: Clear separation of concerns
- **Dependency Injection**: Using Riverpod for better testability
- **Immutable State**: Using Freezed for reliable state management
- **Declarative UI**: Flutter widgets with clear responsibilities
- **Error Handling**: Consistent error handling through ApiResponse class

### Performance Considerations

- Efficient color operations using withAlpha instead of withOpacity
- Lazy loading for better memory management
- Shimmer loading for better UX during data fetching
- Hero animations for smooth transitions
- Pagination for handling large datasets

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request
