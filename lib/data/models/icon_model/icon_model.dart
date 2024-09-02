import 'package:hive/hive.dart';

part 'icon_model.g.dart';

@HiveType(typeId: 6)
class IconModel extends HiveObject {
  @HiveField(0)
  final String path; // Path to the icon asset or user-uploaded image

  @HiveField(1)
  final bool isDefault; // Flag to distinguish default icons from user-added icons

  IconModel({required this.path, required this.isDefault});
}
