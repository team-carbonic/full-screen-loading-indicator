// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class FullScreenLoadingIndicator {
  const FullScreenLoadingIndicator._();

  static GlobalKey<NavigatorState>? _navigatorKey;

  /// [navigatorKey] is usually a root naviator key.
  /// It is used to hide the loading indicator when an error occurs and the context used to show is no longer available.
  static void setNavigatorKey(final GlobalKey<NavigatorState> navigatorKey) {
    _navigatorKey = navigatorKey;
  }

  /// Shows a full screen loading indicator while [func] is running.
  /// Returns the result of [func] when it completes.
  /// If [func] throws an error, the loading indicator is hidden and the error is rethrown.
  /// If the context used to show the loading indicator is no longer available and [setNavigatorKey] was called, the loading indicator is hidden using the navigator key.
  static FutureOr<T?> show<T>(
    final BuildContext context,
    final FutureOr<T?> Function() func,
  ) async {
    if (!context.mounted || context.loaderOverlay.visible) {
      return null;
    }

    T? result;
    try {
      context.loaderOverlay.show();

      result = await func();
      _hide(context);
    } catch (_) {
      _hide(context);
      rethrow;
    }
    return result;
  }

  static void _hide(final BuildContext context) {
    try {
      if (!context.mounted) {
        throw Exception();
      }
      context.loaderOverlay.hide();
    } catch (_) {
      _navigatorKey?.currentContext?.loaderOverlay.hide();
    }
  }
}
