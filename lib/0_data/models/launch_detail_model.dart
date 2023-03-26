import 'package:equatable/equatable.dart';
import 'package:space_x_demo/0_data/models/crew_model.dart';
import 'package:space_x_demo/0_data/models/launchpad_model.dart';
import 'package:space_x_demo/0_data/models/rocket_model.dart';
import 'package:space_x_demo/1_domain/entities/launch_detail_entity.dart';

class LaunchDetailModel extends LaunchDetailEntity with EquatableMixin {
  const LaunchDetailModel({
    required super.id,
    required super.name,
    required super.dateUtc,
    required super.success,
    required super.upcoming,
    required super.details,
    required super.crew,
    required super.rocket,
    required super.launchpad,
    required super.article,
    required super.wikipedia,
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
}
