import 'dart:collection';

import 'package:flutter/material.dart';

class SnackBarQueue {
  final Queue<SnackBar> _snackBars = Queue();

  void show(BuildContext context, SnackBar snackBar) {
    _snackBars.add(snackBar);

    if (_snackBars.length == 1) {
      _showNext(context);
    }
  }

  void _showNext(BuildContext context) {
    if (_snackBars.isNotEmpty) {
      final snackBar = _snackBars.first;

      ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((_) {
        _snackBars.removeFirst();
        _showNext(context);
      });
    }
  }
}
