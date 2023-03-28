import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:space_x_demo/constants/constants.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ElasticIn(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.md,
            vertical: Constants.sm,
          ),
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(Constants.md),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red,
                    size: Constants.xlg,
                  ),
                  const SizedBox(width: Constants.sm),
                  Expanded(
                    child: Text(
                      message,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
