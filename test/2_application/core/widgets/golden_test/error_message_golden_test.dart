import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:space_x_demo/2_application/core/widgets/error_message.dart';

import '../../../../../test_utils/test_utils.dart';

// # Run all tests.
// * flutter test

// # Only run golden tests.
// * flutter test --tags golden

// # Run all tests except golden tests.
// * flutter test --exclude-tags golden

void main() {
  Widget widgetUnderTest({required String message}) {
    return Scaffold(
      body: ErrorMessage(message: message),
    );
  }

  group('ErrorMessage golden', () {
    testGoldens(
      'should be displayed correctly in different devices',
      (tester) async {
        final builder = DeviceBuilder()
          ..overrideDevicesForAllScenarios(devices: [
            Device.iphone11,
            Device.phone,
            const Device(
              name: '300 x 300',
              size: Size(300, 300),
            ),
          ])
          ..addScenario(
            widget: widgetUnderTest(message: 'error_message'),
            name: 'normal text',
          )
          ..addScenario(
            widget: widgetUnderTest(
              message:
                  'Culpa veniam eiusmod anim esse adipisicing minim esse deserunt reprehenderit cupidatat deserunt.Laboris qui magna elit occaecat.',
            ),
            name: 'long message',
          )
          ..addScenario(
            widget: widgetUnderTest(message: ''),
            name: 'no message',
          );

        await pumpDeviceBuilderWithThemeWrapper(
            tester: tester, deviceBuilder: builder);
        await screenMatchesGolden(tester, 'error_message');
      },
    );
  });
}




// * alchemist package

// goldenTest(
//   'should be displayed correctly',
//   fileName: 'error_message',
//   builder: () => GoldenTestGroup(
//     scenarioConstraints:
//         const BoxConstraints(maxWidth: ConstantsTest.maxWidth),
//     children: [
//       GoldenTestScenario(
//         name: 'normal message',
//         child: const ErrorMessage(message: 'error_message'),
//       ),
//       GoldenTestScenario(
//         name: 'long message',
//         child: const ErrorMessage(
//           message:
//               'Culpa veniam eiusmod anim esse adipisicing minim esse deserunt reprehenderit cupidatat deserunt.Laboris qui magna elit occaecat.',
//         ),
//       ),
//       GoldenTestScenario(
//         name: 'no message',
//         child: const ErrorMessage(message: ''),
//       ),
//     ],
//   ),
// );
