import 'package:flutter/material.dart';

class PulseArguments<T> {
  final T data;
  PulseArguments(this.data);
}

class PulseRoute<T> extends MaterialPageRoute<T> {
  final PulseArguments<T>? arguments;
  PulseRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    this.arguments,
  }) : super(
          builder: builder,
          settings: settings,
        );
}
