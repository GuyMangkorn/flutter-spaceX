import 'package:equatable/equatable.dart';

class CrewModel extends Equatable {
  final String id;
  final String name;
  final String agency;
  final String image;
  final String wikipedia;
  final String status;
  const CrewModel({
    required this.id,
    required this.name,
    required this.agency,
    required this.image,
    required this.wikipedia,
    required this.status,
  });

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

  @override
  List<Object?> get props => [id, name, agency, image, wikipedia, status];
}
