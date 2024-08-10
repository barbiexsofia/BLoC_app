import 'package:flutter/material.dart';

class StackedSnackBarManager extends StatefulWidget {
  final Widget child;

  const StackedSnackBarManager({super.key, required this.child});

  @override
  _StackedSnackBarManagerState createState() => _StackedSnackBarManagerState();

  static _StackedSnackBarManagerState? of(BuildContext context) {
    return context.findAncestorStateOfType<_StackedSnackBarManagerState>();
  }
}

class _StackedSnackBarManagerState extends State<StackedSnackBarManager>
    with TickerProviderStateMixin {
  final List<_SnackBarEntry> _snackBarEntries = [];

  void showMessage(String message) {
    final _SnackBarEntry entry = _SnackBarEntry(message, this);
    setState(() {
      _snackBarEntries.add(entry);
    });

    // Start the fade-out sequence after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        entry.controller.forward(); // Start the fade-out animation
      }
    });

    entry.controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _snackBarEntries.remove(entry);
        });
      }
    });
  }

  @override
  void dispose() {
    for (var entry in _snackBarEntries) {
      entry.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          bottom: 20.0,
          left: 20.0,
          right: 20.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _snackBarEntries.map((entry) {
              return AnimatedBuilder(
                animation: entry.controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: 1.0 - entry.controller.value,
                    child: child,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Material(
                    color: Theme.of(context).snackBarTheme.backgroundColor ??
                        Colors.grey[800],
                    elevation: 6.0,
                    borderRadius: BorderRadius.circular(4.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              entry.message,
                              style: Theme.of(context)
                                      .snackBarTheme
                                      .contentTextStyle ??
                                  const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _SnackBarEntry {
  final String message;
  final AnimationController controller;

  _SnackBarEntry(this.message, TickerProvider tickerProvider)
      : controller = AnimationController(
          duration: const Duration(milliseconds: 400),
          vsync: tickerProvider,
        );
}
