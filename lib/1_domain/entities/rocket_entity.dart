import 'package:equatable/equatable.dart';

class RocketEntity extends Equatable {
  final String id;
  final String name;
  final List<String> images;
  final int successRatePct;
  final String country;
  final String company;
  final String description;
  const RocketEntity({
    required this.id,
    required this.name,
    required this.images,
    required this.successRatePct,
    required this.country,
    required this.company,
    required this.description,
  });

  @override
  List<Object?> get props => [];
}
