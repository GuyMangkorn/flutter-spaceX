import 'package:equatable/equatable.dart';

class FilterModel extends Equatable {
  const FilterModel({
    this.filterByName = false,
    this.filterByDate = true,
    this.filterFlag = -1,
  });
  final bool filterByName;
  final bool filterByDate;
  final int filterFlag;

  @override
  List<Object?> get props => [
        filterByName,
        filterByDate,
        filterFlag,
      ];
}
