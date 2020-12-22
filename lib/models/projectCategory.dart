import 'dart:convert';

ProjectCategory projectCategoryFromJson(String str) => ProjectCategory.fromJson(json.decode(str));

String projectCategoryToJson(ProjectCategory data) => json.encode(data.toJson());

class ProjectCategory {
  ProjectCategory({
    this.id,
    this.url,
    this.name,
    this.description,
    this.visible,
    this.order,
  });

  int id;
  String url;
  String name;
  String description;
  bool visible;
  int order;

  factory ProjectCategory.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return ProjectCategory(
      id: json['id'],
      url: json['url'],
      name: json['name'],
      description: json['description'],
      visible: json['visible'],
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'url': url,
    'name': name,
    'description': description,
    'visible': visible,
    'order': order,
  };
}
