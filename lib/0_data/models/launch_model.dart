import 'package:equatable/equatable.dart';
import 'package:space_x_demo/1_domain/entities/launch_entity.dart';

class LaunchModel extends LaunchEntity with EquatableMixin {
  const LaunchModel({
    required super.id,
    required super.name,
    required super.dateUtc,
    required super.success,
    required super.upcoming,
    required super.images,
    required super.patch,
  });

  factory LaunchModel.fromJson(Map<String, dynamic> json) {
    return LaunchModel(
      id: json['id'],
      name: json['name'],
      dateUtc: '${json['date_utc']}'.split("T")[0],
      success: json['success'] ?? false,
      upcoming: json['upcoming'] ?? false,
      images:
          fromListDynamicToString(json['links']['flickr']['original'] ?? []),
      patch: json['links']['patch']['small'] ?? '',
    );
  }

  static List<String> fromListDynamicToString(List<dynamic> list) {
    return list.map((e) => e.toString()).toList();
  }

  static List<LaunchModel> fromListJson(List<dynamic> data) {
    return data.map((e) {
      return LaunchModel.fromJson(e);
    }).toList();
  }
}
