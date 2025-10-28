// welcome_view_model.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeViewModel extends ChangeNotifier {
  Timer? _timer;
  bool _navigated = false;

  void startTimer(BuildContext context) {
    _timer = Timer(const Duration(seconds: 3), () => goNext(context));
  }

  void goNext(BuildContext context) {
    if (_navigated) return;
    _navigated = true;
    context.go('/home');
  }

  void disposeTimer() {
    _timer?.cancel();
  }
}
