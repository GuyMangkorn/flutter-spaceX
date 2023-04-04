import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_demo/0_data/models/launchpad_model.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/launchpad_section.dart';
import 'package:space_x_demo/constants/mock_constants.dart';
import 'package:space_x_demo/generated/l10n.dart';

import '../../../../../../test_utils/test_utils.dart';

void main() {
  LaunchpadModel createSubject({
    String id = 'id',
    String name = 'name',
    String fullName = 'fullName',
    String locality = 'locality',
    String region = 'region',
    int launchAttempts = 105,
    int launchSuccesses = 105,
    String details = 'details',
    List<String> image = const [],
  }) {
    return LaunchpadModel(
      id: id,
      name: name,
      fullName: fullName,
      locality: locality,
      region: region,
      launchAttempts: launchAttempts,
      launchSuccesses: launchSuccesses,
      details: details,
      image: image,
    );
  }

  Widget widgetUnderTest({required LaunchpadModel launchpadEntity}) {
    return MaterialApp(
      home: LaunchpadSection(
        launchpad: launchpadEntity,
        intl: S(),
      ),
    );
  }

  group('LaunchpadSection', () {
    late LaunchpadModel mockLaunchpad;

    setUp(() {
      mockLaunchpad = createSubject();
    });
    testWidgets('displayed static header correctly', (widgetTester) async {
      await widgetTester
          .pumpWidget(widgetUnderTest(launchpadEntity: mockLaunchpad));
      await widgetTester.pumpAndSettle();

      final headerWidget = find.textContaining(S().launchpad);

      expect(headerWidget, findsOneWidget);
    });
    group('should be displayed correctly', () {
      testWidgets('when a Launchpad without image given', (widgetTester) async {
        const name = 'name_test';
        const fullName = 'fullname_test';
        const details = 'details_test';
        mockLaunchpad = createSubject(
          name: name,
          fullName: fullName,
          details: details,
        );
        await widgetTester
            .pumpWidget(widgetUnderTest(launchpadEntity: mockLaunchpad));
        await widgetTester.pumpAndSettle();

        final nameWidget = find.text(name);
        final fullNameWidget = find.text(fullName);
        final detailWidget = find.text(details);
        final imageWidget = find.byType(FadeInImage);

        expect(nameWidget, findsOneWidget);
        expect(fullNameWidget, findsOneWidget);
        expect(detailWidget, findsOneWidget);
        expect(imageWidget, findsNothing);
      });

      testWidgets('when a Launchpad with long text given',
          (widgetTester) async {
        const name =
            'Elit et anim proident occaecat eiusmod incididunt sint.Enim irure id eiusmod occaecat enim Lorem.';
        const fullName =
            'Sunt et anim ullamco veniam ex irure dolore laboris nulla occaecat eiusmod consequat.Sint adipisicing sint enim fugiat eiusmod et.';
        const details =
            'Reprehenderit deserunt mollit labore sint sit duis magna aute.Ullamco est aliquip sit cillum dolore velit duis Lorem eu id do laborum sint voluptate.';
        mockLaunchpad = createSubject(
          name: name,
          fullName: fullName,
          details: details,
        );
        await widgetTester
            .pumpWidget(widgetUnderTest(launchpadEntity: mockLaunchpad));
        await widgetTester.pumpAndSettle();

        final nameWidget = find.textContaining(name);
        final fullNameWidget = find.textContaining(fullName);
        final detailWidget = find.textContaining(details);
        final imageWidget = find.byType(FadeInImage);

        expect(nameWidget, findsOneWidget);
        expect(fullNameWidget, findsOneWidget);
        expect(detailWidget, findsOneWidget);
        expect(imageWidget, findsNothing);
      });

      testWidgets('when a Launchpad with image empty list given',
          (widgetTester) async {
        mockLaunchpad = createSubject(image: []);
        await widgetTester
            .pumpWidget(widgetUnderTest(launchpadEntity: mockLaunchpad));
        await widgetTester.pumpAndSettle();

        final imageWidget = find.byWidgetPredicate(
            (widget) => widget is Image && widget.image is AssetImage);

        expect(imageWidget, findsNothing);
      });

      testWidgets('when a Launchpad with image empty String given',
          (widgetTester) async {
        mockLaunchpad = createSubject(image: ['']);
        await widgetTester
            .pumpWidget(widgetUnderTest(launchpadEntity: mockLaunchpad));
        await widgetTester.pumpAndSettle();

        final placeHolderWidget = find.byWidgetPredicate(
            (widget) => widget is Image && widget.image is AssetImage);

        // * check empty string show placeholder
        expect(placeHolderWidget, findsOneWidget);
      });

      testWidgets('when a Launchpad with a image given', (widgetTester) async {
        mockLaunchpad = createSubject(image: [MockConstants.mockNetworkURL]);
        await mockNetworkImagesFor(() async => await widgetTester
            .pumpWidget(widgetUnderTest(launchpadEntity: mockLaunchpad)));
        await widgetTester.pump(const Duration(milliseconds: 500));

        final imageWidget = find.byWidgetPredicate(
            (widget) => widget is Image && widget.image is NetworkImage);
        expect(imageWidget, findsOneWidget);
      });
    });
  });
}
