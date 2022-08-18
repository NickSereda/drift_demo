import 'package:auto_route/auto_route.dart';
import 'package:drift_demo/main.dart';
import 'package:flutter/material.dart';

abstract class DialogService {
  const DialogService._();

  static BuildContext? _context;

  static GlobalKey<NavigatorState> get _navigatorKey => appRouter.navigatorKey;

  static Future<void> displayDialog({
    required String title,
    required String message,
  }) async {
    if (_context == null) {
      return;
    }
    return showDialog(
      context: _navigatorKey.currentContext!,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (context) {
        _context = context;
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  close();
                },
                child: const Text("Close"))
          ],
        );
      },
    );
  }

  static Future<void> displayErrorDialog({
    required String title,
    required String message,
  }) async {
    if (_context == null) {
      return;
    }
    return showDialog(
      context: _navigatorKey.currentContext!,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (context) {
        _context = context;
        return AlertDialog(
          backgroundColor: Theme.of(context).errorColor,
          title: Text(
            title,
            style: TextStyle(color: Theme.of(context).colorScheme.onError),
          ),
          content: Text(
            message,
            style: TextStyle(color: Theme.of(context).colorScheme.onError),
          ),
          actions: [
            TextButton(
              onPressed: () {
                close();
              },
              child: Text(
                "Close",
                style: TextStyle(color: Theme.of(context).colorScheme.onError),
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<bool> confirmOperation() async {
    return await showDialog<bool>(
          context: _navigatorKey.currentContext!,
          builder: (context) => AlertDialog(
            title: const Text('Do you confirm this operation?'),
            actions: [
              TextButton(
                child: const Text('No'),
                onPressed: () => _context!.router.pop(false),
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () => _context!.router.pop(true),
              ),
            ],
          ),
        ) ??
        false;
  }

  static void close() {
    if (_context != null) {
      Navigator.pop(_context!);
    }
  }
}
