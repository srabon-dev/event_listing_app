import '../../../../app_export.dart';

class CategoryEntities {
  final String id;
  final String name;
  final String categoryImage;
  final String type;

  CategoryEntities({
    required this.id,
    this.name = "",
    this.type = "",
    this.categoryImage = AppConfig.defaultCategory,
  });
}
