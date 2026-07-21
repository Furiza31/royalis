pragma Singleton

import QtQuick
import Quickshell

Singleton {
    readonly property url wallpaper:
        Quickshell.shellPath("assets/wallpapers/default.png")

    readonly property color wallpaperFallback: "#FFFFFF"
}