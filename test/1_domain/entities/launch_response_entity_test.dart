import 'package:flutter_test/flutter_test.dart';
import 'package:space_x_demo/1_domain/entities/launch_entity.dart';
import 'package:space_x_demo/1_domain/entities/launch_response_entity.dart';

void main() {
  LaunchResponseEntity createSubject({required int index}) {
    return LaunchResponseEntity(list: [
      LaunchEntity(
        dateUtc: 'dateUtc$index',
        id: 'id$index',
        name: 'name$index',
        success: index == 1 ? true : false,
        upcoming: index == 1 ? true : false,
        images: ['image$index'],
        patch: 'patch$index',
      )
    ]);
  }

  group('LaunchResponseEntity', () {
    test('two instances with the same data should be equal', () {
      final obj1 = createSubject(index: 1);
      final obj2 = createSubject(index: 1);

      expect(obj1, equals(obj2));
    });

    test('two instances with different data should not be equal', () {
      final obj1 = createSubject(index: 1);
      final obj2 = createSubject(index: 2);

      expect(obj1, isNot(obj2));
    });
  });
}
