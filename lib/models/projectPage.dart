import 'dart:convert';

List<ProjectPage> projectPageFromJson(String str) => List<ProjectPage>.from(json.decode(str).map((x) => ProjectPage.fromJson(x)));

String projectPageToJson(List<ProjectPage> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectPage {
  ProjectPage({
    this.id,
    this.name,
    this.html,
    this.orderPosition,
    this.published,
  });

  int id;
  String name;
  String html;
  int orderPosition;
  bool published;

  factory ProjectPage.fromJson(Map<String, dynamic> json) => ProjectPage(
    id: json["id"],
    name: json["name"],
    html: json["html"],
    orderPosition: json["order_position"],
    published: json["published"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "html": html,
    "order_position": orderPosition,
    "published": published,
  };
}
