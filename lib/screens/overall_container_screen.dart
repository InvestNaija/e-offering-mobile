import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OverallContainer extends StatefulWidget {
  final Widget child;
  final BuildContext context;
  final VoidCallback onTimeExpired;

  OverallContainer({
    @required this.child,
    @required this.context,
    this.onTimeExpired,
  });

  static OverallContainerState of(BuildContext context) {
    return (context
        .dependOnInheritedWidgetOfExactType<_InheritedStateContainer>())
        .data;
  }

  @override
  OverallContainerState createState() => new OverallContainerState();
}

class OverallContainerState extends State<OverallContainer> {
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    _initializeTimer();

    return new _InheritedStateContainer(
      data: this,
      child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: _handleUserInteraction,
          onPanDown: _handleUserInteraction,
          child: widget.child),
    );
  }

  void _handleUserInteraction([_]) {
    refreshTimer();
  }

  void _initializeTimer() {
     if (_timer != null) {
       _timer.cancel();
     }
     _timer = Timer(const Duration(seconds: 60), _logOutUser);
  }

  void refreshTimer() {
    if (_timer != null) {
      _timer.cancel();
    }

    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
    _timer = Timer(const Duration(seconds: 60), _logOutUser);
  }

  void _logOutUser() {
     widget.onTimeExpired();
     _timer?.cancel();
     _timer = null;
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final OverallContainerState data;

  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}
