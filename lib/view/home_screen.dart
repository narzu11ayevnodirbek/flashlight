import 'package:flashlight/paint/light_bulb_painter.dart';
import 'package:flashlight/view_model/flashlight_view_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOn = false;

  void _handleTap(Offset tapPosition, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = 60.0;

    final distance = (tapPosition - center).distance;

    if (distance < radius) {
      setState(() {
        isOn = !isOn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<FlashlightViewModel>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF2A2A2A),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.biggest;

          return GestureDetector(
            onTapDown: (details) {
              final tapPos = details.localPosition;
              _handleTap(tapPos, size);
              vm.toggleFlashlight();
            },
            child: CustomPaint(
              painter: LightBulbPainter(isOn: isOn),
              size: Size.infinite,
            ),
          );
        },
      ),
    );
  }
}
