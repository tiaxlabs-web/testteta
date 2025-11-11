import 'dart:math';
import 'package:flutter/material.dart';

class MysticalParticle {
  double x;
  double y;
  double size;
  double speed;
  double opacity;
  final String symbol;
  final Color color;

  MysticalParticle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.symbol,
    required this.color,
  });
}

class MysticalParticles extends StatefulWidget {
  final int particleCount;

  const MysticalParticles({
    super.key,
    this.particleCount = 30,
  });

  @override
  State<MysticalParticles> createState() => _MysticalParticlesState();
}

class _MysticalParticlesState extends State<MysticalParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<MysticalParticle> particles;
  final Random _random = Random();

  final List<String> mysticalSymbols = [
    '✨',
    '⭐',
    '🌟',
    '💫',
    '🔮',
    '🌙',
    '☪️',
    '🪬',
    '✦',
    '✧',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    particles = List.generate(widget.particleCount, (index) {
      return MysticalParticle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 20 + 10,
        speed: _random.nextDouble() * 0.0005 + 0.0002,
        opacity: _random.nextDouble() * 0.5 + 0.2,
        symbol: mysticalSymbols[_random.nextInt(mysticalSymbols.length)],
        color: [
          Colors.purple.shade200,
          Colors.blue.shade200,
          Colors.pink.shade200,
          Colors.amber.shade200,
        ][_random.nextInt(4)],
      );
    });

    _controller.addListener(() {
      setState(() {
        for (var particle in particles) {
          particle.y -= particle.speed;
          if (particle.y < -0.1) {
            particle.y = 1.1;
            particle.x = _random.nextDouble();
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: ParticlePainter(particles),
        size: Size.infinite,
      ),
    );
  }
}

class ParticlePainter extends CustomPainter {
  final List<MysticalParticle> particles;

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: particle.symbol,
          style: TextStyle(
            fontSize: particle.size,
            color: particle.color.withOpacity(particle.opacity),
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          particle.x * size.width - textPainter.width / 2,
          particle.y * size.height - textPainter.height / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
