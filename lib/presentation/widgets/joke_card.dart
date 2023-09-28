import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:jokes/main.dart';

class JokeCard extends StatelessWidget {
  final String joke;
  const JokeCard({
    Key? key,
    required this.joke,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 450),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(
        horizontal: 2.0,
        vertical: 16.0,
      ),
      decoration: BoxDecoration(
        color: context.white(),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 20.0,
            // offset: const Offset(0, 1),
            spreadRadius: 5.0,
          )
        ],
      ),
      child: Text(
        joke,
        style: context.customStyle(
          size: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    )
        .animate()
        .fadeIn(
          duration: 350.ms,
        )
        .slideX(duration: 450.ms);
  }
}
