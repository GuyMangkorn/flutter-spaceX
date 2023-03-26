import 'package:equatable/equatable.dart';
import 'package:space_x_demo/1_domain/entities/crew_entity.dart';
import 'package:space_x_demo/1_domain/entities/laucnhpad_entity.dart';
import 'package:space_x_demo/1_domain/entities/rocket_entity.dart';

class LaunchDetailEntity extends Equatable {
  final String id;
  final String name;
  final String dateUtc;
  final bool success;
  final bool upcoming;
  final String details;
  final String article;
  final String wikipedia;
  final List<CrewEntity> crew;
  final RocketEntity rocket;
  final LaunchpadEntity launchpad;
  
  const LaunchDetailEntity({
    required this.dateUtc,
    required this.id,
    required this.name,
    required this.success,
    required this.upcoming,
    required this.details,
    required this.article,
    required this.wikipedia,
    required this.crew,
    required this.rocket,
    required this.launchpad,
  });

  @override
  List<Object?> get props =>
      [id, name, dateUtc, success, upcoming, crew, rocket, launchpad];
}
