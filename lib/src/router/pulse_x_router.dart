import 'package:flutter/material.dart';
import 'package:pulse_x/src/errors/pulse_x_errors.dart';
import 'package:pulse_x/src/router/pulse_x_route.dart';

/// Navigation service using global navigator key
class PulseXNavigator {
  PulseXNavigator._();
  static final PulseXNavigator _instance = PulseXNavigator._();
  factory PulseXNavigator() => _instance;

  /// Global navigator key which which is placed in your [MaterialApp]
  /// Example usage:
  ///
  /// return MaterialApp(
  /// register global navigator key here
  /// navigatorKey: PulseNavigator.navigatorKey,
  /// );

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// navigate to a new screen
  ///
  ///
  /// Example Usage:
  /// PulseXNavigator navigator = PulseXNavigator();
  /// navigator.push(ExampleView());
  Future<Object?>? push<T extends Widget>(T route) {
    BuildContext? context = navigatorKey.currentState?.context;
    assert(context != null, PulseXErrors.contextNotFoundError());
    return navigatorKey.currentState?.push(
      PulseXRoute(
        builder: (_) => route,
      ),
    );
  }

  /// Navigate to a new route using route name
  /// TODO: this function is still under development
  Future<Object?>? pushNamed<T>(String routeName, {PulseXArguments<T>? arguments}) {
    BuildContext? context = navigatorKey.currentState?.context;
    assert(context != null, PulseXErrors.contextNotFoundError());

    return navigatorKey.currentState?.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  /// Receives arguments when navigating to a new route with parameters
  ///
  ///
  /// Example Usage:
  /// PulseXNavigator navigator = PulseNavigator();
  /// PulseXArguments<String> args = navigator.getArgs<String>();
  /// String argument = args.data;
  PulseXArguments<T> getArgs<T>() {
   BuildContext? context = navigatorKey.currentState?.context;
    assert(context != null, PulseXErrors.contextNotFoundError());

    return ModalRoute.of<T>(context!)?.settings.arguments as PulseXArguments<T>;
  }

  void pop<T>([T? result]) {
    BuildContext? context = navigatorKey.currentState?.context;
    assert(context != null, PulseXErrors.contextNotFoundError());

    return navigatorKey.currentState?.pop(result);
  }
}
