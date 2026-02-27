# Responsive Layout Demo

This file documents the responsive layout created for the SafeGate app.

## Overview
A simple responsive screen using `Container`, `Row`, `Column`, `Expanded`, and `MediaQuery`.
The implementation is in `lib/screens/responsive_layout.dart`.

## Key UI decisions
- Header section at the top using a full-width `Container`.
- For narrow screens the layout stacks vertically (two panels in a `Column`).
- For wide screens the layout lays out two panels side-by-side in a `Row`.
- Uses `Expanded` to keep panels proportional to available space.

## Code snippet (Row / Column / Container usage)

```dart
// Header
Container(
  width: double.infinity,
  height: 150,
  color: Colors.lightBlueAccent,
  child: Center(child: Text('Header Section')),
);

// Responsive body
final isWide = MediaQuery.of(context).size.width > 600;

Expanded(
  child: isWide
    ? Row(children: [Expanded(child: left), SizedBox(width:10), Expanded(child: right)])
    : Column(children: [Expanded(child: top), SizedBox(height:10), Expanded(child: bottom)])
)
```

## Screenshots
- Add portrait phone screenshot: `screenshots/phone-portrait.png`
- Add landscape/tablet screenshot: `screenshots/tablet-landscape.png`

## Reflection
- Why responsiveness matters: ensures UI works well on many device sizes and orientations.
- Challenges: managing spacing and text scaling so nothing overflows on small devices.
- Improvements: add `Flexible`, responsive typography, and orientation-specific layouts.

## How to run
From the `safegate_app` folder run:

```bash
flutter run -d <device>
```

Open the `ResponsiveLayout` screen in the app to preview.
