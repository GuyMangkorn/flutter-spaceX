import 'package:equatable/equatable.dart';
import 'package:space_x_demo/0_data/models/crew_model.dart';
import 'package:space_x_demo/0_data/models/launchpad_model.dart';
import 'package:space_x_demo/0_data/models/rocket_model.dart';

class LaunchDetailModel extends Equatable {
  final String id;
  final String name;
  final String dateUtc;
  final bool success;
  final bool upcoming;
  final String details;
  final String article;
  final String wikipedia;
  final List<CrewModel> crew;
  final RocketModel rocket;
  final LaunchpadModel launchpad;

  const LaunchDetailModel({
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

  factory LaunchDetailModel.fromJson(Map<String, dynamic> json) {
    return LaunchDetailModel(
      id: json['id'],
      name: json['name'],
      dateUtc: '${json['date_utc']}'.split("T")[0],
      success: json['success'] ?? false,
      upcoming: json['upcoming'] ?? false,
      details: json['details'] ?? '',
      article: json['links']['article'] ?? '',
      wikipedia: json['links']['wikipedia'] ?? '',
      crew: CrewModel.fromListJson(json['crew'] ?? []),
      rocket: RocketModel.fromJson(json['rocket'] ?? {}),
      launchpad: LaunchpadModel.fromJson(json['launchpad'] ?? {}),
    );
  }

  static List<String> fromListDynamicToString(List<dynamic> list) {
    return list.map((e) => e.toString()).toList();
  }

  static List<LaunchDetailModel> fromListJson(List<dynamic> list) {
    return list.map((e) => LaunchDetailModel.fromJson(e)).toList();
  }

  @override
  List<Object?> get props => [
        id,
        name,
        dateUtc,
        success,
        upcoming,
        details,
        article,
        wikipedia,
        crew,
        rocket,
        launchpad,
      ];
}
