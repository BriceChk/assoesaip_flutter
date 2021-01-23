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
    this.logoFileName,
    this.order,
  });

  int id;
  String url;
  String name;
  String description;
  String logoFileName;
  bool visible;
  int order;

  factory ProjectCategory.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return ProjectCategory(
      id: json['id'],
      url: json['url'],
      name: json['name'],
      description: json['description'],
      logoFileName: json['logo_file_name'],
      visible: json['visible'],
      order: json['list_order'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'url': url,
    'name': name,
    'description': description,
    'logo_file_name': logoFileName,
    'visible': visible,
    'list_order': order,
  };
}
