import 'package:equatable/equatable.dart';

class CrewEntity extends Equatable {
  final String id;
  final String name;
  final String agency;
  final String image;
  final String wikipedia;
  final String status;
  const CrewEntity({
    required this.id,
    required this.name,
    required this.agency,
    required this.image,
    required this.wikipedia,
    required this.status,
  });

  @override
  List<Object?> get props => [id, agency, image, wikipedia, status];
}
