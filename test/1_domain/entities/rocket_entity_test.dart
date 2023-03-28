import 'package:flutter_test/flutter_test.dart';
import 'package:space_x_demo/1_domain/entities/rocket_entity.dart';

void main() {
  RocketEntity createSubject({required int index}) {
    return RocketEntity(
      id: 'id$index',
      name: 'name$index',
      images: ['image$index'],
      successRatePct: index,
      country: 'country$index',
      company: 'company$index',
      description: 'description$index',
    );
  }

  group('RocketEntity', () {
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
