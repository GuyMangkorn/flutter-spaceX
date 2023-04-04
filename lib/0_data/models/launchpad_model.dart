import 'package:equatable/equatable.dart';

class LaunchpadModel extends Equatable {
  final String id;
  final String name;
  final String fullName;
  final String locality;
  final String region;
  final int launchAttempts;
  final int launchSuccesses;
  final String details;
  final List<String> image;

  const LaunchpadModel({
    required this.id,
    required this.name,
    required this.fullName,
    required this.locality,
    required this.region,
    required this.launchAttempts,
    required this.launchSuccesses,
    required this.details,
    required this.image,
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

  @override
  List<Object?> get props => [
        id,
        name,
        fullName,
        locality,
        region,
        launchAttempts,
        launchSuccesses,
        details,
        image
      ];
}
