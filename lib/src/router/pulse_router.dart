import 'package:flutter/material.dart';
import 'package:pulse/src/errors/pulse_errors.dart';
import 'package:pulse/src/router/pulse_route.dart';

class PulseNavigator {
  PulseNavigator._();
  static final PulseNavigator _instance = PulseNavigator._();
  factory PulseNavigator() => _instance;

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<T?>? push<T extends Widget>(T route) {
    BuildContext? context = navigatorKey.currentState?.context;
    assert(context != null, PulseErrors.contextNotFoundError());

    return navigatorKey.currentState?.push(
      PulseRoute(
        builder: (_) => route,
      ),
    );
  }

  Future<T?>? pushNamed<T>(String routeName, {PulseArguments<T>? arguments}) {
    BuildContext? context = navigatorKey.currentState?.context;
    assert(context != null, PulseErrors.contextNotFoundError());

    return navigatorKey.currentState?.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  PulseArguments<T> getArgs<T>() {
    BuildContext? context = navigatorKey.currentState?.context;
    assert(context != null, PulseErrors.contextNotFoundError());

    return ModalRoute.of<T>(context!)?.settings.arguments as PulseArguments<T>;
  }

  void pop<T>([T? result]) {
    BuildContext? context = navigatorKey.currentState?.context;
    assert(context != null, PulseErrors.contextNotFoundError());

    return navigatorKey.currentState?.pop(result);
  }
}
