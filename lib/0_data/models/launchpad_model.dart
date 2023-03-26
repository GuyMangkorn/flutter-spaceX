import 'package:equatable/equatable.dart';
import 'package:space_x_demo/1_domain/entities/laucnhpad_entity.dart';

class LaunchpadModel extends LaunchpadEntity with EquatableMixin {
  LaunchpadModel({
    required super.id,
    required super.name,
    required super.fullName,
    required super.locality,
    required super.region,
    required super.launchAttempts,
    required super.launchSuccesses,
    required super.details,
    required super.image,
  });

  factory LaunchpadModel.fromJson(Map<String, dynamic> json) {
    return LaunchpadModel(
      id: json['id'],
      name: json['name'],
      fullName: json['full_name'],
      locality: json['locality'],
      region: json['region'],
      launchAttempts: json['launch_attempts'],
      launchSuccesses: json['launch_successes'],
      details: json['details'],
      image: fromListDynamicToString(json['images']['large'] ?? []),
    );
  }

  static List<String> fromListDynamicToString(List<dynamic> list) {
    return list.map((e) => e.toString()).toList();
  }
}
