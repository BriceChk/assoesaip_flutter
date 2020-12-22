import 'dart:convert';

EventOccurrence eventOccurrenceFromJson(String str) => EventOccurrence.fromJson(json.decode(str));

String eventOccurrenceToJson(EventOccurrence data) => json.encode(data.toJson());

class EventOccurrence {
  EventOccurrence({
    this.id,
    this.date,
  });

  int id;
  DateTime date;

  factory EventOccurrence.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return EventOccurrence(
      id: json['id'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
  };
}
