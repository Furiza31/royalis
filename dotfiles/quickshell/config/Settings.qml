pragma Singleton

import Quickshell

Singleton {
    readonly property url wallpaper:
        Quickshell.shellPath("assets/wallpapers/default.jpg")

    readonly property color wallpaperFallback: "#FFFFFF"
}