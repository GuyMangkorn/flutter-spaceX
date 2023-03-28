import 'package:flutter_test/flutter_test.dart';
import 'package:space_x_demo/1_domain/entities/crew_entity.dart';
import 'package:space_x_demo/1_domain/entities/laucnhpad_entity.dart';
import 'package:space_x_demo/1_domain/entities/launch_detail_entity.dart';
import 'package:space_x_demo/1_domain/entities/rocket_entity.dart';

void main() {
  LaunchDetailEntity createSubject({required int index}) {
    return LaunchDetailEntity(
        dateUtc: 'dateUtc$index',
        id: 'id$index',
        name: 'name$index',
        success: index == 1 ? true : false,
        upcoming: index == 1 ? true : false,
        details: 'details$index',
        article: 'article$index',
        wikipedia: 'wikipedia$index',
        crew: [
          CrewEntity(
            id: 'id$index',
            name: 'name$index',
            agency: 'agency$index',
            image: 'image$index',
            wikipedia: 'wikipedia$index',
            status: 'status$index',
          )
        ],
        rocket: RocketEntity(
          id: 'id$index',
          name: 'name$index',
          images: ['image$index'],
          successRatePct: index,
          country: 'country$index',
          company: 'company$index',
          description: 'description$index',
        ),
        launchpad: LaunchpadEntity(
          id: 'id$index',
          name: 'name$index',
          fullName: 'fullName$index',
          locality: 'locality$index',
          region: 'region$index',
          launchAttempts: index,
          launchSuccesses: index,
          details: 'details$index',
          image: ['image$index'],
        ));
  }

  group('LaunchDetailEntity', () {
    test('two instances with the same data should be equal', () {
      final obj1 = createSubject(index: 1);
      final obj2 = createSubject(index: 1);

      expect(obj1, obj2);
    });

    test('two instances with different data should not be equal', () {
      final obj1 = createSubject(index: 1);
      final obj2 = createSubject(index: 2);

      expect(obj1, isNot(obj2));
    });
  });
}
