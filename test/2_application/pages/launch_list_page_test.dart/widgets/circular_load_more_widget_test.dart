import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/widgets/circular_load_more.dart';
import 'package:space_x_demo/generated/l10n.dart';

void main() {
  Widget widgetUnderTest({required String loadMoreText}) {
    return MaterialApp(
      home: CircularLoadMore(loadMoreText: loadMoreText),
      locale: const Locale('en'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    );
  }

  group('CircularLoadMore', () {
    group('should be display correctly', () {
      testWidgets('when a loading text given', (widgetTester) async {
        final text = S().loading_more;
        await widgetTester.pumpWidget(widgetUnderTest(loadMoreText: text));
        await widgetTester.pump(const Duration(milliseconds: 500));

        final loadMoreTextParams = widgetTester
            .widget<CircularLoadMore>(find.byType(CircularLoadMore))
            .loadMoreText;
        final textWidget = find.textContaining(text);
        final circularWidget = find.byType(CircularProgressIndicator);

        expect(loadMoreTextParams, text);
        expect(textWidget, findsOneWidget);
        expect(circularWidget, findsOneWidget);
      });
    });
  });
}
