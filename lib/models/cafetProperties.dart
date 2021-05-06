import 'dart:convert';

import 'package:assoesaip_flutter/models/cafetItem.dart';

CafetProperties cafetPropertiesFromJson(String str) => CafetProperties.fromJson(json.decode(str));

String cafetPropertiesToJson(CafetProperties data) => json.encode(data.toJson());

class CafetProperties {
  CafetProperties({
    this.items,
    this.isOpen,
    this.message,
  });

  List<CafetItem>? items;
  bool? isOpen;
  String? message;

  factory CafetProperties.fromJson(Map<String, dynamic> json) => CafetProperties(
    items: List<CafetItem>.from(json["items"].map((x) => CafetItem.fromJson(x))),
    isOpen: json["is_open"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "is_open": isOpen,
    "message": message,
  };
}