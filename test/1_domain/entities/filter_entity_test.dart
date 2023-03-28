import 'package:flutter_test/flutter_test.dart';
import 'package:space_x_demo/1_domain/entities/filter_entity.dart';

void main() {
  FilterEntity createSubject({required int index}) {
    return FilterEntity(
      filterByDate: index == 1 ? true : false,
      filterByName: index == 1 ? true : false,
      filterFlag: 1,
    );
  }

  group('FilterEntity', () {
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
