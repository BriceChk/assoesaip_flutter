import 'dart:convert';

EventCategory eventCategoryFromJson(String str) => EventCategory.fromJson(json.decode(str));

String eventCategoryToJson(EventCategory data) => json.encode(data.toJson());

class EventCategory {
  EventCategory({
    this.id,
    this.name,
    this.color,
  });

  int id;
  String name;
  String color;

  factory EventCategory.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return EventCategory(
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
