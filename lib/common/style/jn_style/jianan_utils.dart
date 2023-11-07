import 'package:flutter/material.dart';

class NanUtils {
  static EdgeInsets edgeLR(double padding) =>
      EdgeInsets.fromLTRB(padding, 0, padding, 0);

  static EdgeInsets edgeTB(double padding) =>
      EdgeInsets.fromLTRB(0, padding, 0, padding);

  static Container boxContainer({
    Widget? child,
    Color color = Colors.white,
    double radius = 15,
    EdgeInsets edge = const EdgeInsets.all(6),
    Color borderColor = Colors.white,
    double borderWidth = 2,
    double? width,
    double? height,
    bool radiusTop = false,
    bool showBorder = false,
    List<BoxShadow>? boxShadow,
  }) =>
      Container(
          width: width,
          height: height,

          decoration: BoxDecoration(
            border: (showBorder)
                ? Border.all(width: borderWidth, color: borderColor)
                : null,
            color: color,
            borderRadius: (radiusTop)
                ? BorderRadius.vertical(top: Radius.circular(radius))
                : BorderRadius.circular(radius),
            boxShadow: boxShadow,
          ),
          child: Padding(
            padding: edge,
            child: child,
          ));
}
