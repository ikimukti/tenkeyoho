import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SliderDotWidget extends StatelessWidget {
  bool isActive;
  SliderDotWidget({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(
        left: 4,
        right: 4,
      ),
      width: isActive ? 16 : 8,
      height: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: isActive ? Colors.white : Colors.white.withOpacity(0.4),
      ),
    );
  }
}
