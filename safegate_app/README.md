# Flutter Environment Setup and First App Run

## Steps Followed

1. Installed Flutter SDK and added it to system PATH.
2. Installed Android Studio and Android SDK.
3. Created and launched Android Emulator using AVD Manager.
4. Ran Flutter Doctor to verify setup.
5. Ran an existing Flutter app on the emulator.

## Setup Verification

### Flutter Doctor Output
![img_1.png](img_1.png)

### Running Flutter App on Emulator
![img.png](img.png)

## Reflection

During the setup, I faced challenges such as downloading Android system images and configuring the Android SDK path. After resolving these issues, Flutter Doctor showed a healthy environment. This setup prepares me to build, test, and debug real mobile applications efficiently using an emulator or physical device.

# Widget Tree Demo App

## Project Title
Widget Tree and Reactive UI Demo

## Short Description
This demo app illustrates the concept of the widget tree in Flutter and demonstrates the reactive UI model through interactive state changes. It features a simple counter with buttons to increment the count and change the background color, showcasing how Flutter rebuilds only the affected parts of the UI.

## Widget Tree Hierarchy

```
MaterialApp
┣ Scaffold
  ┣ AppBar
  ┃ ┗ Text ('Widget Tree Demo')
  ┗ Center
    ┗ Column
      ┣ Text ('Count:')
      ┣ Text ('$count')
      ┣ SizedBox
      ┣ ElevatedButton ('Increment')
      ┃ ┗ Text ('Increment')
      ┣ SizedBox
      ┗ ElevatedButton ('Change Background Color')
        ┗ Text ('Change Background Color')
```

## Screenshots

### Initial UI State
![initial_state.png](initial_state.png)

### Updated UI After State Change
![updated_state.png](updated_state.png)

## Explanations

### What is a Widget Tree?
In Flutter, the widget tree is a hierarchical structure where every element of the UI is a widget. Widgets are the building blocks of the Flutter UI, and they form a tree with parent-child relationships. The root is typically the MaterialApp or CupertinoApp, and it branches out to various layout and UI widgets like Scaffold, Column, Text, etc. Each widget can have children, creating a nested structure that defines the entire user interface.

### How Does the Reactive Model Work in Flutter?
Flutter's UI is reactive, meaning it automatically updates the UI when the underlying data (state) changes. Instead of manually redrawing the entire screen, Flutter uses a declarative approach where you describe what the UI should look like based on the current state. When state changes (e.g., via setState()), Flutter rebuilds the widget tree, but only the parts that depend on the changed state are actually re-rendered. This is efficient because Flutter compares the old and new widget trees and updates only the differences.

### Why Does Flutter Rebuild Only Parts of the Tree and Not the Entire UI?
Flutter rebuilds only the affected parts of the widget tree to optimize performance. When setState() is called, it marks the widget as needing a rebuild. During the build process, Flutter creates a new widget tree and compares it to the previous one using a process called "reconciliation." Only the widgets that have changed are updated in the actual render tree, minimizing the work needed to update the UI. This selective rebuilding ensures smooth animations and interactions, even on lower-end devices.