import 'package:flutter_test/flutter_test.dart';
import 'package:space_x_demo/1_domain/entities/laucnhpad_entity.dart';

void main() {
  LaunchpadEntity createSubject({required int index}) {
    return LaunchpadEntity(
      id: 'id$index',
      name: 'name$index',
      fullName: 'fullName$index',
      locality: 'locality$index',
      region: 'region$index',
      launchAttempts: index,
      launchSuccesses: index,
      details: 'details$index',
      image: ['image$index'],
    );
  }

  group('LaunchpadEntity', () {
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
