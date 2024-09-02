import 'package:hive/hive.dart';

part 'step_model.g.dart';

@HiveType(typeId: 4)
class StepModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String photo;

  @HiveField(4)
  final int hour;
  @HiveField(5)
  final int minute;
  @HiveField(6)
  final List<String> ingredientsIdList;

  StepModel({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
    required this.hour,
    required this.minute,
    required this.ingredientsIdList,
  });

  /// Creates a copy of this object with the given fields replaced with the new values
  StepModel copyWith({
    String? id,
    String? name,
    String? description,
    String? photo,
    int? hour,
    int? minute,
    List<String>? ingredientsIdList,
  }) {
    return StepModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      photo: photo ?? this.photo,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      ingredientsIdList: ingredientsIdList ?? this.ingredientsIdList,
    );
  }

  factory StepModel.empty() => StepModel(
        id: '',
        name: '',
        description: '',
        photo: '',
        hour: 0,
        minute: 0,
        ingredientsIdList: [],
      );
}
