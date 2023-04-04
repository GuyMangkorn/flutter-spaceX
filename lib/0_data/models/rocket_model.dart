import 'package:equatable/equatable.dart';

class RocketModel extends Equatable {
  final String id;
  final String name;
  final List<String> images;
  final int successRatePct;
  final String country;
  final String company;
  final String description;
  const RocketModel({
    required this.id,
    required this.name,
    required this.images,
    required this.successRatePct,
    required this.country,
    required this.company,
    required this.description,
  });

  factory RocketModel.fromJson(Map<String, dynamic> json) {
    return RocketModel(
      id: json['id'],
      name: json['name'],
      images: fromListDynamicToString(json['flickr_images'] ?? []),
      company: json['company'],
      country: json['country'],
      description: json['description'],
      successRatePct: json['success_rate_pct'],
    );
  }

  static List<String> fromListDynamicToString(List<dynamic> list) {
    return list.map((e) => e.toString()).toList();
  }

  @override
  List<Object?> get props => [
        id,
        name,
        images,
        successRatePct,
        country,
        company,
        description,
      ];
}
