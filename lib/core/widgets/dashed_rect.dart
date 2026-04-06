import 'dart:ui';

import 'package:flutter/material.dart';

class DashboardDashedContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double borderRadius;
  final Color backgroundColor;
  final Color dashColor;
  final double strokeWidth;
  final double dashGap;
  final EdgeInsetsGeometry? padding;
  final Widget? child;

  const DashboardDashedContainer({
    super.key,
    this.height,
    this.width,
    this.child,
    this.padding,
    this.borderRadius = 20,
    this.backgroundColor = Colors.white,
    this.dashColor = Colors.black,
    this.strokeWidth = 2,
    this.dashGap = 6,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: height,
        width: width,
        color: backgroundColor,
        child: CustomPaint(
          painter: _DashedBorderPainter(
            color: dashColor,
            strokeWidth: strokeWidth,
            gap: dashGap,
            radius: borderRadius,
          ),
          child: Padding(
            padding: padding ?? EdgeInsets.all(12),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double radius;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.gap,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rect);

    final dashPattern = <double>[gap, gap];

    final dashedPath = _createDashedPath(path, dashPattern);

    canvas.drawPath(dashedPath, paint);
  }

  Path _createDashedPath(Path source, List<double> dashArray) {
    final Path dest = Path();
    for (final PathMetric metric in source.computeMetrics()) {
      double distance = 0.0;
      bool draw = true;

      while (distance < metric.length) {
        final double length = dashArray[draw ? 0 : 1];
        final double next = distance + length;

        if (draw) {
          dest.addPath(metric.extractPath(distance, next), Offset.zero);
        }

        distance = next;
        draw = !draw;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}