import 'dart:convert';

import 'package:assoesaip_flutter/models/projectCategory.dart';
import 'package:assoesaip_flutter/models/projectSocialInfo.dart';

Project projectFromJson(String str) => Project.fromJson(json.decode(str));

String projectToJson(Project data) => json.encode(data.toJson());

class Project {
  Project({
    this.id,
    this.name,
    this.url,
    this.type,
    this.category,
    this.campus,
    this.parentProject,
    this.keywords,
    this.email,
    this.social,
    this.description,
    this.logoFileName,
    this.html,
    this.dateAdded,
    this.dateModified,
    this.childrenProjects,
  });

  int id;
  String name;
  String url;
  String type;
  ProjectCategory category;
  String campus;
  Project parentProject;
  String keywords;
  String email;
  ProjectSocialInfo social;
  String description;
  String logoFileName;
  String html;
  DateTime dateAdded;
  DateTime dateModified;
  List<Project> childrenProjects;

  factory Project.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return Project(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      type: json['type'],
      category: json['category'] == null ? null : ProjectCategory.fromJson(json['category']),
      campus: json['campus'],
      parentProject: json['parent_project'] == null ? null : Project.fromJson(json['parent_project']),
      keywords: json['keywords'],
      email: json['email'],
      social: json['social'] is List ? null : ProjectSocialInfo.fromJson(json['social']),
      description: json['description'],
      logoFileName: json['logo_file_name'],
      html: json['html'],
      dateAdded: json['date_added'] == null ? null : DateTime.parse(json['date_added']),
      dateModified: json['date_modified'] == null ? null : DateTime.parse(json['date_modified']),
      childrenProjects: json['children_projects'] == null ? null : List<Project>.from(json['children_projects'].map((x) => Project.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'url': url,
    'type': type,
    'category': category == null ? null : category.toJson(),
    'campus': campus,
    'parent_project': parentProject == null ? null : parentProject.toJson(),
    'keywords': keywords,
    'email': email,
    'social': social == null ? null : social.toJson(),
    'description': description,
    'logo_file_name': logoFileName,
    'html': html,
    'date_added': dateAdded == null ? null : dateAdded.toIso8601String(),
    'date_modified': dateModified == null ? null : dateModified.toIso8601String(),
    'children_projects': childrenProjects == null ? null : List<dynamic>.from(childrenProjects.map((e) => e.toJson())),
  };
}