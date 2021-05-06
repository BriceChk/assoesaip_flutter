import 'dart:convert';

import 'package:assoesaip_flutter/models/event.dart';

EventOccurrence eventOccurrenceFromJson(String str) => EventOccurrence.fromJson(json.decode(str));

String eventOccurrenceToJson(EventOccurrence data) => json.encode(data.toJson());

class EventOccurrence {
  EventOccurrence({
    this.id,
    this.date,
    this.event,
  });

  int? id;
  DateTime? date;
  Event? event;

  factory EventOccurrence.fromJson(Map<String, dynamic>? json) {
    if (json == null) return EventOccurrence();

    return EventOccurrence(
      id: json['id'],
      date: DateTime.parse(json['date']),
      event: json['event'] == null ? null : Event.fromJson(json['event']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date!.toIso8601String(),
    'event': event == null ? null : event!.toJson(),
  };
}
