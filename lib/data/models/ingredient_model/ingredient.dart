import 'package:hive/hive.dart';
import 'package:pp_438/core/helpers/enums.dart';
import 'package:uuid/uuid.dart';

part 'ingredient.g.dart';

@HiveType(typeId: 1)
class Ingredient extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int amount;
  @HiveField(3)
  int amountAdd;
  @HiveField(4)
  Unit unit;
  @HiveField(5)
  String note;
  @HiveField(6)
  String icon;

  Ingredient({
    String? id,
    required this.name,
    required this.amount,
    required this.amountAdd,
    required this.unit,
    required this.note,
    required this.icon,
  }) : id = id ?? Uuid().v1();

  factory Ingredient.empty() => Ingredient(
        name: '',
        amountAdd: 0,
        amount: 0,
        unit: Unit.kgg,
        note: '',
        icon: '',
      );

  Ingredient copyWith({
    String? id,
    String? name,
    int? amount,
    int? amountAdd,
    Unit? unit,
    String? note,
    String? icon,
  }) {
    return Ingredient(
      id: id ?? this.id,
      name: name ?? this.name,
      amountAdd: amountAdd ?? this.amountAdd,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      note: note ?? this.note,
      icon: icon ?? this.icon,
    );
  }
}
