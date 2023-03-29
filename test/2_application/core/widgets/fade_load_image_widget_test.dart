import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:space_x_demo/2_application/core/widgets/fade_load_image.dart';

import '../../../../test_constant/test_constants.dart';

void main() {
  Widget widgetUnderTest({
    required String image,
    double? height,
    double? width,
  }) {
    return MaterialApp(
      home: FadeLoadImage(
        image: image,
        height: height,
        width: width,
      ),
    );
  }

  group('FadeLoadImage', () {
    group('should be display correctly', () {
      testWidgets('when an empty image URL was given', (widgetTester) async {
        const url = '';
        const double width = 400;
        const double height = 200;
        await widgetTester.pumpWidget(widgetUnderTest(
          image: url,
          width: width,
          height: height,
        ));
        await widgetTester.pumpAndSettle();

        final placeHolderImage = find.byWidgetPredicate((widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            widget.width == width &&
            widget.height == height);

        expect(placeHolderImage, findsOneWidget);
      });

      testWidgets('when an image URL was given', (widgetTester) async {
        const url = ConstantsTest.mockNetworkURL;
        const double width = 400;
        const double height = 200;
        await mockNetworkImagesFor(
          () async => await widgetTester.pumpWidget(widgetUnderTest(
            image: url,
            width: width,
            height: height,
          )),
        );
        await widgetTester.pump();

        final placeHolderImage = find.byWidgetPredicate((widget) =>
            widget is Image &&
            widget.image is NetworkImage &&
            widget.width == width &&
            widget.height == height);

        expect(placeHolderImage, findsOneWidget);
      });
    });
  });
}
