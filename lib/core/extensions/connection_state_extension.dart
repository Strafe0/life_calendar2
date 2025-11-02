import 'package:flutter/material.dart';

extension ConnectionStateExtension on ConnectionState {
  bool get isLoading =>
      this == ConnectionState.active ||
      this == ConnectionState.waiting ||
      this == ConnectionState.none;
}
