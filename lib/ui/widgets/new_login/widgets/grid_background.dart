// lib/widgets/grid_background.dart
import 'package:flutter/material.dart';

import '../../../theme/blueprint_colors.dart';

/// Renders the engineering blueprint grid background.
class GridBackground extends StatelessWidget {
  const GridBackground({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) => CustomPaint(
      painter: _GridPainter(),
      child: child,
    );
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = BpColors.gridLine
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const double step = 20;

    // Vertical lines
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    // Horizontal lines
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) => false;
}
