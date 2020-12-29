import 'dart:convert';

import 'package:assoesaip_flutter/models/eventCategory.dart';
import 'package:assoesaip_flutter/models/eventOccurrence.dart';
import 'package:assoesaip_flutter/models/project.dart';
import 'package:assoesaip_flutter/models/user.dart';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  Event({
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
    this.dateStart,
    this.dateEnd,
    this.duration,
    this.allDay,
    this.daysOfWeek,
    this.intervalCount,
    this.intervalType,
    this.occurrencesCount,
    this.occurrences,
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
  EventCategory category;
  DateTime dateStart;
  DateTime dateEnd;
  int duration;
  bool allDay;
  String daysOfWeek;
  int intervalCount;
  String intervalType;
  int occurrencesCount;
  List<EventOccurrence> occurrences;

  factory Event.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return Event(
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
      category: json['category'] == null ? null : EventCategory.fromJson(json['category']),
      dateStart: json['date_start'] == null ? null : DateTime.parse(json['date_start']),
      dateEnd: json['date_end'] == null ? null : DateTime.parse(json['date_end']),
      duration: json['duration'],
      allDay: json['all_day'],
      daysOfWeek: json['days_of_week'].toString(),
      intervalCount: json['interval_count'],
      intervalType: json['interval_type'],
      occurrencesCount: json['occurrences_count'],
      occurrences: json['occurrences'] == null ? null : List<EventOccurrence>.from(json['occurrences'].map((x) => EventOccurrence.fromJson(x))),
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
    'date_start': dateStart == null ? null : dateStart.toIso8601String(),
    'date_end': dateEnd == null ? null : dateEnd.toIso8601String(),
    'duration': duration,
    'all_day': allDay,
    'days_of_week': daysOfWeek,
    'interval_count': intervalCount,
    'interval_type': intervalType,
    'occurrences_count': occurrencesCount,
    'occurrences': occurrences == null ? null : List<dynamic>.from(occurrences.map((x) => x.toJson())),
  };
}