import 'package:flutter/material.dart';

class PulseXArguments<T> {
  final T data;
  PulseXArguments(this.data);
}

class PulseXRoute<T> extends MaterialPageRoute<T> {
  final PulseXArguments<T>? arguments;
  PulseXRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    this.arguments,
  }) : super(
          builder: builder,
          settings: settings,
        );
}
