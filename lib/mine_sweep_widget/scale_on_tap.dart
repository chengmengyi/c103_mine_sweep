import 'package:flutter/material.dart';

class ScaleOnTap extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double scaleFactor;
  final Duration duration;

  const ScaleOnTap({
    super.key,
    required this.child,
    required this.onTap,
    this.scaleFactor = 1.1,
    this.duration = const Duration(milliseconds: 100),
  });

  @override
  State<ScaleOnTap> createState() => _ScaleOnTapState();
}

class _ScaleOnTapState extends State<ScaleOnTap> {
  double _scale = 1.0;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _scale = widget.scaleFactor;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: widget.duration,
        child: widget.child,
      ),
    );
  }
}
