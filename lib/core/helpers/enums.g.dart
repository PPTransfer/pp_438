// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeCategoryAdapter extends TypeAdapter<RecipeCategory> {
  @override
  final int typeId = 2;

  @override
  RecipeCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RecipeCategory.breakfast;
      case 1:
        return RecipeCategory.dinner;
      case 2:
        return RecipeCategory.lunch;
      case 3:
        return RecipeCategory.dessert;
      case 4:
        return RecipeCategory.grill;
      case 5:
        return RecipeCategory.snack;
      default:
        return RecipeCategory.breakfast;
    }
  }

  @override
  void write(BinaryWriter writer, RecipeCategory obj) {
    switch (obj) {
      case RecipeCategory.breakfast:
        writer.writeByte(0);
        break;
      case RecipeCategory.dinner:
        writer.writeByte(1);
        break;
      case RecipeCategory.lunch:
        writer.writeByte(2);
        break;
      case RecipeCategory.dessert:
        writer.writeByte(3);
        break;
      case RecipeCategory.grill:
        writer.writeByte(4);
        break;
      case RecipeCategory.snack:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UnitAdapter extends TypeAdapter<Unit> {
  @override
  final int typeId = 3;

  @override
  Unit read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Unit.kgg;
      case 1:
        return Unit.pcs;
      case 2:
        return Unit.lboz;
      default:
        return Unit.kgg;
    }
  }

  @override
  void write(BinaryWriter writer, Unit obj) {
    switch (obj) {
      case Unit.kgg:
        writer.writeByte(0);
        break;
      case Unit.pcs:
        writer.writeByte(1);
        break;
      case Unit.lboz:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
