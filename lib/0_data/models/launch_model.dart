import 'package:equatable/equatable.dart';

class LaunchModel extends Equatable {
  final String id;
  final String name;
  final String dateUtc;
  final bool success;
  final bool upcoming;
  final List<String> images;
  final String patch;

  const LaunchModel(
      {required this.dateUtc,
      required this.id,
      required this.name,
      required this.success,
      required this.upcoming,
      required this.images,
      required this.patch});

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
