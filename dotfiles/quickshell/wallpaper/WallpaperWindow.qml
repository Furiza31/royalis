import QtQuick
import Quickshell
import Quickshell.Wayland

import qs.config

PanelWindow {
    id: root

    required property var modelData

    screen: modelData

    anchors {
        top: true
        right: true
        bottom: true
        left: true
    }

    exclusionMode: ExclusionMode.Ignore

    focusable: false

    color: Settings.wallpaperFallback

    mask: Region {}

    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.namespace: "quickshell-wallpaper"

    Image {
        id: wallpaperImage

        anchors.fill: parent

        source: Settings.wallpaper

        fillMode: Image.PreserveAspectCrop
        clip: true

        asynchronous: true
        autoTransform: true

        smooth: true
        mipmap: true
    }
}