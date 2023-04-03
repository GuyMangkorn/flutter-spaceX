import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:space_x_demo/constants/constants.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart' as anno;
import 'package:widgetbook/widgetbook.dart';

@anno.WidgetbookUseCase(name: 'Default', type: ErrorMessage)
Widget errorMessageUseCase(BuildContext context) {
  return ErrorMessage(
    message: context.knobs.text(
      label: 'Message Label',
      initialValue: 'Error Message',
    ),
  );
}

@anno.WidgetbookUseCase(name: 'Long message', type: ErrorMessage)
Widget longErrorMessageUseCase(BuildContext context) {
  return ErrorMessage(
    message: context.knobs.text(
      label: 'Message Label',
      initialValue:
          'Error Message Ex commodo labore consequat laboris fugiat dolor sint.Qui eu sint quis non sit Lorem adipisicing pariatur excepteur incididunt.',
    ),
  );
}

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
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Theme.of(context).colorScheme.error,
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
