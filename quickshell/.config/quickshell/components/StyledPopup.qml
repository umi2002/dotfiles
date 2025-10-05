import QtQuick

Item {
    id: root
    required property bool isExpanded
    required property Component popupContent

    property int animationDuration: 400
    property var animationEasing: Easing.InOutBack

    width: loader.width
    height: loader.height

    Loader {
        id: loader
        sourceComponent: root.popupContent

        onItemChanged: {
            if (item) {
                item.isExpanded = Qt.binding(() => root.isExpanded);
                loader.width = Qt.binding(() => item.implicitWidth);
                loader.height = Qt.binding(() => item.implicitHeight);
            }
        }

        Behavior on height {
            NumberAnimation {
                duration: root.animationDuration
                easing.type: root.animationEasing
            }
        }
    }
}
