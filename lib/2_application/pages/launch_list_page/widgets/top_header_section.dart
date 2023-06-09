import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:space_x_demo/constants/constants.dart';

class TopHeaderSection extends StatelessWidget {
  const TopHeaderSection({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      textAlign: TextAlign.right,
      style: Theme.of(context).textTheme.headlineMedium!,
      child: Row(
        children: [
          const SizedBox(width: Constants.md),
          const Icon(
            Icons.rocket_sharp,
            size: Constants.lg,
          ),
          const SizedBox(width: Constants.xs),
          Flexible(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: RepaintBoundary(
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TyperAnimatedText(
                    '...',
                    speed: const Duration(
                      milliseconds: 1500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
