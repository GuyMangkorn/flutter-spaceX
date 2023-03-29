import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_demo/1_domain/entities/rocket_entity.dart';
import 'package:space_x_demo/2_application/core/widgets/fade_load_image.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/widgets/rocket_section.dart';
import 'package:space_x_demo/generated/l10n.dart';

import '../../../../constants_test.dart';

void main() {
  late RocketEntity mockRocket;
  RocketEntity createSubject({
    String id = 'id',
    String name = 'name',
    List<String> images = const [],
    int successRatePct = 0,
    String country = 'country',
    String company = 'company',
    String description = 'description',
  }) {
    return RocketEntity(
      id: id,
      name: name,
      images: images,
      successRatePct: successRatePct,
      country: country,
      company: company,
      description: description,
    );
  }

  Widget widgetUnderTest({required RocketEntity rocket}) {
    return MaterialApp(
      home: RocketSection(rocket: rocket, intl: S()),
    );
  }

  setUp(() {
    mockRocket = createSubject();
  });

  group('RocketSection', () {
    testWidgets('displayed static header correctly', (widgetTester) async {
      await widgetTester.pumpWidget(widgetUnderTest(rocket: mockRocket));
      await widgetTester.pumpAndSettle();

      final headerWidget = find.text(S().rocket);

      expect(headerWidget, findsOneWidget);
    });

    group('should be display correctly', () {
      testWidgets('when a short message Rocket given', (widgetTester) async {
        const rocketName = 'test_name';
        const company = 'test_company';
        const description = 'test_description';
        mockRocket = createSubject(
            name: rocketName, company: company, description: description);

        await widgetTester.pumpWidget(widgetUnderTest(rocket: mockRocket));
        await widgetTester.pumpAndSettle();

        final nameWidget = find.textContaining(rocketName);
        final companyWidget = find.textContaining(company);
        final descriptionWidget = find.text(description);

        expect(nameWidget, findsOneWidget);
        expect(companyWidget, findsOneWidget);
        expect(descriptionWidget, findsOneWidget);
      });

      testWidgets('when a long message Rocket given', (widgetTester) async {
        const rocketName =
            'test_name Qui consequat pariatur aliquip mollit dolore elit enim.Id dolor Lorem sint nostrud anim excepteur voluptate deserunt do elit nostrud mollit magna dolore.';
        const company =
            'test_company Ullamco laborum est laborum do fugiat sit ex ea incididunt velit.Ut amet qui consectetur anim dolor ad Lorem ipsum commodo sunt nisi officia.';
        const description =
            'test_descriptionEnim cillum mollit fugiat dolor do cillum veniam est occaecat veniam dolor in.Ipsum et ex aute consectetur aliqua sit culpa officia.';
        mockRocket = createSubject(
            name: rocketName, company: company, description: description);

        await widgetTester.pumpWidget(widgetUnderTest(rocket: mockRocket));
        await widgetTester.pumpAndSettle();

        final nameWidget = find.textContaining(rocketName);
        final companyWidget = find.textContaining(company);
        final descriptionWidget = find.text(description);

        expect(nameWidget, findsOneWidget);
        expect(companyWidget, findsOneWidget);
        expect(descriptionWidget, findsOneWidget);
      });

      testWidgets('when a image list wasn\'t given', (widgetTester) async {
        mockRocket = createSubject(images: []);

        await widgetTester.pumpWidget(widgetUnderTest(rocket: mockRocket));
        await widgetTester.pumpAndSettle();

        final imageWidget = find.byType(FadeLoadImage);
        expect(imageWidget, findsNothing);
      });

      testWidgets('when a image list with empty string was given',
          (widgetTester) async {
        mockRocket = createSubject(images: ['', '']);
        await widgetTester.pumpWidget(widgetUnderTest(rocket: mockRocket));
        await widgetTester.pumpAndSettle();

        final placeHolderWidget = find.byWidgetPredicate(
            (widget) => widget is Image && widget.image is AssetImage);
        expect(placeHolderWidget, findsAtLeastNWidgets(1));
      });

      testWidgets('when a image list with url was given', (widgetTester) async {
        mockRocket = createSubject(images: [ConstantsTest.mockNetworkURL]);
        await mockNetworkImagesFor(() async =>
            await widgetTester.pumpWidget(widgetUnderTest(rocket: mockRocket)));
        await widgetTester.pump(const Duration(milliseconds: 500));

        final placeHolderWidget = find.byWidgetPredicate(
            (widget) => widget is Image && widget.image is NetworkImage);
        expect(placeHolderWidget, findsOneWidget);
      });
    });
  });
}
