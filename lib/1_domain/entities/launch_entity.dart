import 'package:equatable/equatable.dart';

class LaunchEntity extends Equatable {
  final String id;
  final String name;
  final String dateUtc;
  final bool success;
  final bool upcoming;
  final List<String> images;
  final String patch;

  const LaunchEntity(
      {required this.dateUtc,
      required this.id,
      required this.name,
      required this.success,
      required this.upcoming,
      required this.images,
      required this.patch});

  @override
  List<Object?> get props => [
        id,
        name,
        dateUtc,
        success,
        upcoming,
        images,
        patch,
      ];
}
