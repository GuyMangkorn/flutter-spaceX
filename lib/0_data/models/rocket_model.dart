import 'package:equatable/equatable.dart';
import 'package:space_x_demo/1_domain/entities/rocket_entity.dart';

class RocketModel extends RocketEntity with EquatableMixin {
  RocketModel({
    required super.id,
    required super.name,
    required super.images,
    required super.successRatePct,
    required super.country,
    required super.company,
    required super.description,
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
}
