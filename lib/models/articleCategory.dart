import 'dart:convert';

ArticleCategory articleCategoryFromJson(String str) => ArticleCategory.fromJson(json.decode(str));

String articleCategoryToJson(ArticleCategory data) => json.encode(data.toJson());

class ArticleCategory {
  ArticleCategory({
    this.id,
    this.name,
    this.color,
  });

  int? id;
  String? name;
  String? color;

  factory ArticleCategory.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ArticleCategory();

    return ArticleCategory(
      id: json['id'],
      name: json['name'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'color': color,
  };
}
