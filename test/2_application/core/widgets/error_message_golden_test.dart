import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_x_demo/2_application/core/widgets/error_message.dart';

import '../../../../test_constant/test_constants.dart';

// # Run all tests.
// * flutter test

// # Only run golden tests.
// * flutter test --tags golden

// # Run all tests except golden tests.
// * flutter test --exclude-tags golden

void main() {
  group('ErrorMessage', () {
    goldenTest(
      'should be displayed correctly',
      fileName: 'error_message',
      builder: () => GoldenTestGroup(
        scenarioConstraints:
            const BoxConstraints(maxWidth: ConstantsTest.maxWidth),
        children: [
          GoldenTestScenario(
            name: 'normal message',
            child: const ErrorMessage(message: 'error_message'),
          ),
          GoldenTestScenario(
            name: 'long message',
            child: const ErrorMessage(
                message:
                    'Culpa veniam eiusmod anim esse adipisicing minim esse deserunt reprehenderit cupidatat deserunt.Laboris qui magna elit occaecat.'),
          ),
          GoldenTestScenario(
            name: 'no message',
            child: const ErrorMessage(message: ''),
          ),
        ],
      ),
    );
  });
}
