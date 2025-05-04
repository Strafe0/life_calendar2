import 'package:flutter/material.dart';

enum DeviceType { phone, tablet }

DeviceType getDeviceType() {
  final view = WidgetsBinding.instance.platformDispatcher.views.first;
  final double devicePixelRatio = view.devicePixelRatio;
  final double shortestSide = view.physicalSize.shortestSide;

  if (shortestSide / devicePixelRatio < 550) {
    return DeviceType.phone;
  } else {
    return DeviceType.tablet;
  }
}
