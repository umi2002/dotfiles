pragma ComponentBehavior: Bound

import qs.services

import qs.assets

UtilsWidget {
    iconSource: Assets.brightness.getIcon(Brightness.brightness)
    percentage: Brightness.brightness
}
