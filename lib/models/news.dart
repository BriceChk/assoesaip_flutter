import 'dart:convert';

import 'package:assoesaip_flutter/models/article.dart';
import 'package:assoesaip_flutter/models/event.dart';
import 'package:assoesaip_flutter/models/project.dart';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
  News({
    this.id,
    this.content,
    this.link,
    this.article,
    this.event,
    this.datePublished,
    this.project,
    this.starred,
  });

  int? id;
  String? content;
  String? link;
  Article? article;
  Event? event;
  DateTime? datePublished;
  Project? project;
  bool? starred;

  factory News.fromJson(Map<String, dynamic>? json) {
    if (json == null) return News();

    return News(
      id: json['id'],
      content: json['content'],
      link: json['link'],
      article: json['article'] == null ? null : Article.fromJson(json['article']),
      event: json['event'] == null ? null : Event.fromJson(json['event']),
      datePublished: json['date_published'] == null ? null : DateTime.parse(json['date_published']),
      project: json['project'] == null ? null : Project.fromJson(json['project']),
      starred: json['starred'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'link': link,
    'article': article == null ? null : article!.toJson(),
    'event': event == null ? null : event!.toJson(),
    'date_published': datePublished == null ? null : datePublished!.toIso8601String(),
    'project': project == null ? null : project!.toJson(),
    'starred': starred,
  };
}