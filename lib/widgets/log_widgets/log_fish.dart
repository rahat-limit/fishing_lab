import 'dart:math' as math;
import 'package:flutter/cupertino.dart';

class LogFish extends StatelessWidget {
  const LogFish({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Transform.rotate(
        angle: math.pi / 2,
        child: const Image(
          image: AssetImage(
            'assets/images/fish.png',
          ),
          fit: BoxFit.contain,
          height: 120,
        ),
      ),
    );
  }
}
