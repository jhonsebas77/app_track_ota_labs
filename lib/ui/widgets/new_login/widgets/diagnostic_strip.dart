// lib/widgets/diagnostic_strip.dart
import 'package:flutter/material.dart';

import '../../../theme/blueprint_colors.dart';

/// The animated diagnostic strip from the footer — a moving accent bar.
class DiagnosticStrip extends StatefulWidget {
  const DiagnosticStrip({super.key});

  @override
  State<DiagnosticStrip> createState() => _DiagnosticStripState();
}

class _DiagnosticStripState extends State<DiagnosticStrip>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    _anim = Tween<double>(begin: -0.4, end: 1.2).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
      height: 2,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double totalWidth = constraints.maxWidth;
          double barWidth  = totalWidth * 0.35;

          return AnimatedBuilder(
            animation: _anim,
            builder: (_, __) {
              double left = totalWidth * _anim.value;
              return Stack(
                children: <Widget>[
                  // Track
                  Container(color: BpColors.gridLine),
                  // Moving bar
                  Positioned(
                    left: left,
                    top: 0,
                    bottom: 0,
                    width: barWidth,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Colors.transparent,
                            BpColors.primaryContainer.withAlpha(200),
                            BpColors.primaryContainer,
                            BpColors.primaryContainer.withAlpha(200),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
}
