import 'dart:convert';

import 'package:assoesaip_flutter/models/articleCategory.dart';
import 'package:assoesaip_flutter/models/project.dart';
import 'package:assoesaip_flutter/models/user.dart';

Article articleFromJson(String str) => Article.fromJson(json.decode(str));

String articleToJson(Article data) => json.encode(data.toJson());

class Article {
  Article({
    this.id,
    this.url,
    this.title,
    this.author,
    this.project,
    this.abstract,
    this.html,
    this.dateCreated,
    this.dateEdited,
    this.datePublished,
    this.published,
    this.private,
    this.category,
  });

  int id;
  String url;
  String title;
  User author;
  Project project;
  String abstract;
  String html;
  DateTime dateCreated;
  DateTime dateEdited;
  DateTime datePublished;
  bool published;
  bool private;
  ArticleCategory category;

  factory Article.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return Article(
      id: json['id'],
      url: json['url'],
      title: json['title'],
      author: json['author'] == null ? null : User.fromJson(json['author']),
      project: json['project'] == null ? null : Project.fromJson(json['project']),
      abstract: json['abstract'],
      html: json['html'],
      dateCreated: json['date_created'] == null ? null : DateTime.parse(json['date_created']),
      dateEdited: json['date_edited'] == null ? null : DateTime.parse(json['date_edited']),
      datePublished: json['date_published'] == null ? null : DateTime.parse(json['date_published']),
      published: json['published'],
      private: json['private'],
      category: json['category'] == null ? null : ArticleCategory.fromJson(json['category']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'url': url,
    'title': title,
    'author': author == null ? null : author.toJson(),
    'project': project == null ? null : project.toJson(),
    'abstract': abstract,
    'html': html,
    'date_created': dateCreated == null ? null : dateCreated.toIso8601String(),
    'date_edited': dateEdited == null ? null : dateEdited.toIso8601String(),
    'date_published': datePublished == null ? null : datePublished.toIso8601String(),
    'published': published,
    'private': private,
    'category': category == null ? null : category.toJson(),
  };
}
