import 'package:equatable/equatable.dart';
import 'package:space_x_demo/1_domain/entities/crew_entity.dart';

class CrewModel extends CrewEntity with EquatableMixin {
  CrewModel(
      {required super.id,
      required super.name,
      required super.agency,
      required super.image,
      required super.wikipedia,
      required super.status});

  factory CrewModel.fromJson(Map<String, dynamic> json) {
    return CrewModel(
      id: json['id'],
      name: json['name'],
      agency: json['agency'],
      image: json['image'],
      wikipedia: json['wikipedia'],
      status: json['status'],
    );
  }

  static List<CrewModel> fromListJson(List<dynamic> list) {
    return list.map((e) => CrewModel.fromJson(e)).toList();
  }
}
