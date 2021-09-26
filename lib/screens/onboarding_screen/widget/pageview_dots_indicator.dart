import 'dart:math';

import 'package:flutter/material.dart';

class PageViewDotsIndicator extends AnimatedWidget {
  PageViewDotsIndicator(
      {this.controller,
      this.itemCount,
      this.onPageSelected,
      this.color,
      this.inactiveColor,
      this.kDotSize = 20.0,
      this.kDotSpacing = 32.0})
      : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;
  final Color inactiveColor;

  // The base size of the dots
  double kDotSize;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 1.0;

  // The distance between the center of each dot
  double kDotSpacing;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.15 + (_kMaxZoom - 1.0) * selectedness;

    return Container(
      width: kDotSpacing,
      child: Center(
        child: Material(
          color: controller.page != null
              ? controller.page.round() == index
                  ? color
                  : inactiveColor ??
              Color(0xFF6AC3A3).withOpacity(0.2)
              : index == 0
                  ? color
                  : inactiveColor ??
              Color(0xFF6AC3A3).withOpacity(0.2),
          type: MaterialType.button,
          borderRadius: BorderRadius.circular(5),
          child: Container(
            width: kDotSize * zoom,
            height: 6.0,
            child: InkWell(
              onTap: () {
                if (onPageSelected != null) onPageSelected(index);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildDot));
}
