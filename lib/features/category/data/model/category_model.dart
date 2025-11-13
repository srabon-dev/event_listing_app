class CategoryModel {
  final bool? success;
  final String? message;
  final List<CategoryItem>? data;

  CategoryModel({
    this.success,
    this.message,
    this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<CategoryItem>.from(json["data"]!.map((x) => CategoryItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CategoryItem {
  final String? id;
  final String? name;
  final String? categoryImage;
  final String? type;

  CategoryItem({
    this.id,
    this.name,
    this.categoryImage,
    this.type,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) => CategoryItem(
    id: json["_id"],
    name: json["name"],
    categoryImage: json["category_image"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "category_image": categoryImage,
    "type": type,
  };
}
