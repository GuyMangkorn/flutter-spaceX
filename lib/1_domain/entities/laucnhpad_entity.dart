import 'package:equatable/equatable.dart';

class LaunchpadEntity extends Equatable {
  final String id;
  final String name;
  final String fullName;
  final String locality;
  final String region;
  final int launchAttempts;
  final int launchSuccesses;
  final String details;
  final List<String> image;

  const LaunchpadEntity({
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
