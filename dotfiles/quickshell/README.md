# Quickshell Configuration

This repository contains my Quickshell configuration.

The project is organized **by feature rather than by file type**. Each feature owns its windows, widgets, and related components, making the configuration easier to navigate and maintain as it grows.

## Directory Structure

```text
.
├── shell.qml
├── config/
├── services/
├── components/
├── bar/
├── launcher/
├── notifications/
├── osd/
└── assets/
```

## Philosophy

Instead of having directories like `windows/`, `widgets/`, and `delegates/`, everything is grouped by the feature it belongs to.

For example:

```text
bar/
├── Bar.qml
├── BarWindow.qml
└── widgets/
    ├── ClockWidget.qml
    ├── BatteryWidget.qml
    └── WorkspacesWidget.qml
```

Everything related to the bar lives in one place. If the bar needs changes, there's no need to search through unrelated directories.

## Directory Overview

### `shell.qml`

The application's entry point.

Its only responsibility is to compose the different shell features.

```qml
ShellRoot {
    Bar {}
    Launcher {}
    NotificationCenter {}
    Osd {}
}
```

Keeping this file small makes it easy to understand the overall structure of the shell.

---

### `config/`

Contains shared configuration.

Typical contents include:

* Theme colors
* Fonts
* Border radius
* Spacing
* User preferences
* Animation durations

These values should be reused throughout the project instead of being duplicated.

---

### `services/`

Contains singleton objects responsible for state and system integration.

Examples:

* Battery
* Audio
* Network
* Notifications
* Time
* Media

Services expose data to the rest of the UI.

For example:

```qml
Text {
    text: Time.text
}
```

Widgets consume service data instead of implementing their own logic.

---

### `components/`

Contains reusable UI building blocks.

Examples:

* Buttons
* Labels
* Tooltips
* Popup surfaces
* Styled text
* Common layouts

These components should be generic enough to be reused across multiple features.

---

### `bar/`

Contains everything related to the panel.

Typical contents include:

* Panel window
* Layout
* Widgets
* Feature-specific delegates

Nothing outside of the bar should need to know how the bar is implemented.

---

### `launcher/`

Contains the application launcher.

This may include:

* Search field
* Application delegate
* Category list
* Window

---

### `notifications/`

Contains notification-related components.

Examples:

* Popup notifications
* Notification center
* Notification delegates

---

### `osd/`

Contains on-screen displays.

Examples:

* Volume OSD
* Brightness OSD
* Microphone indicators

---

### `assets/`

Stores static resources.

Examples:

* SVG icons
* Images
* Wallpapers
* Fonts (if bundled)

## Naming Conventions

Use PascalCase for QML files.

Examples:

```text
Bar.qml
ClockWidget.qml
NotificationCenter.qml
StyledText.qml
```

Use descriptive names for specialized components.

Examples:

```text
BatteryWidget.qml
WorkspaceButton.qml
NotificationDelegate.qml
```

Avoid generic names like:

```text
Widget.qml
Button2.qml
Item.qml
```

## Guidelines

### Organize by feature

Keep files that change together together.

Good:

```text
bar/
    Bar.qml
    BarWindow.qml
    widgets/
```

Avoid:

```text
windows/
widgets/
delegates/
```

where files from a single feature become scattered across the project.

---

### Keep services responsible for state

Services should:

* Read system information
* Manage shared state
* Expose properties and signals

Components should simply display that information.

---

### Reuse components

If multiple features use the same UI element, move it into `components/`.

Don't duplicate code.

---

### Keep `shell.qml` small

The root file should only assemble the application.

Business logic belongs inside individual features.

---

### Prefer composition

Small, focused components are easier to maintain than large monolithic files.

If a file grows beyond a few hundred lines, consider extracting reusable pieces into separate components.
