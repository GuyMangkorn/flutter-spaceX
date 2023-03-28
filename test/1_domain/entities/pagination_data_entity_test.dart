import 'package:flutter_test/flutter_test.dart';
import 'package:space_x_demo/1_domain/entities/pagination_data_entity.dart';

void main() {
  PaginationDataEntity createSubject({required int index}) {
    return PaginationDataEntity(
      hasNextPage: index == 1 ? true : false,
      page: index,
    );
  }

  group('PaginationDataEntity', () {
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
