# SafeGate App

A Flutter application demonstrating basic Dart and Flutter concepts with a simple welcome screen that includes state management and user interaction.

## 📁 Folder Structure

```
lib/
├── main.dart          # Entry point of the app, contains the main function and app setup
├── screens/           # Individual UI screens
│   ├── home_page.dart     # Home page widget (future use)
│   ├── login_page.dart    # Login page widget (future use)
│   └── welcome_page.dart  # Welcome screen with state management
├── widgets/           # Reusable UI components (future use)
├── models/            # Data structures (future use)
└── services/          # Firebase or API logic
    ├── auth_service.dart      # Service for Firebase authentication
    ├── firestore_service.dart # Service for Firestore database operations
    └── storage_service.dart   # Service for Firebase storage
```

### Purpose of Each Directory/File
- **lib/**: Contains all the Dart source code for the application.
  - **main.dart**: The root of the application, initializes the app and defines the main widget tree.
  - **screens/**: Houses individual screen widgets for different app pages, promoting separation of UI concerns.
    - **home_page.dart**: Defines the home screen UI after login.
    - **login_page.dart**: Provides the login interface.
    - **welcome_page.dart**: The custom welcome screen with interactive state changes.
  - **widgets/**: For reusable UI components that can be shared across screens.
  - **models/**: Will contain data classes and structures for app data.
  - **services/**: Contains business logic and external service integrations like Firebase.
    - **auth_service.dart**: Handles user authentication logic using Firebase Auth.
    - **firestore_service.dart**: Manages database operations with Cloud Firestore.
    - **storage_service.dart**: Handles file uploads and downloads to Firebase Storage.

### How This Structure Supports Modular App Design
This structure separates concerns by organizing code into logical layers: UI screens, reusable components, data models, and services. This makes the code easier to maintain, test, and scale. For example, authentication logic is isolated in `services/`, allowing it to be reused across different screens without duplication. The modular design supports adding new features without cluttering the main files, and each directory can be developed and tested independently.

### Naming Conventions
- **Files**: Use lowercase with underscores (snake_case), e.g., `auth_service.dart`.
- **Classes**: Use PascalCase, e.g., `AuthService`, `LoginPage`.
- **Widgets**: End with "Page" for full screens or "Widget" for components, e.g., `HomePage`, `WelcomePage`.
- **Variables**: Use camelCase, e.g., `_isWelcomed`.
- **Constants**: Use UPPER_SNAKE_CASE if needed.

## 🚀 Setup Instructions

1. **Install Flutter SDK**: Follow the official guide at [flutter.dev](https://flutter.dev/docs/get-started/install).
2. **Install Android Studio or VS Code**: With Flutter and Dart extensions.
3. **Verify Installation**:
   ```bash
   flutter doctor
   ```
4. **Create and Run the Project**:
   ```bash
   cd safegate_app
   flutter pub get
   flutter run
   ```

## 🧠 Reflection

Through this task, I learned the basics of Dart syntax including classes, state management with StatefulWidget, and event handling with onPressed. Flutter's widget-based architecture makes building UIs intuitive with composable components like Scaffold, Column, and ElevatedButton.

This clean folder structure will help build complex UIs later by keeping code organized. Separating services from UI allows for easier testing and maintenance as the app grows. The modular design supports adding new features without cluttering the main files.

## 📱 Demo

![App Screenshot](screenshot.png)

*(Replace with actual screenshot of the running app)*

## 🎥 Video Demo

[Link to Video Demo](https://example.com/video) *(Upload your 1-2 minute demo showing the app running, structure, and interaction)*

## 📝 Reflection

Integrating Firebase dramatically reduced development time. Instead of spending weeks on backend API development, database schema management, and file storage servers, we focused on the frontend user experience. The "magic" of real-time listeners makes the app feel incredibly responsive and modern.
