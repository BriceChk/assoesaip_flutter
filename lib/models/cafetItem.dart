import 'dart:convert';

List<CafetItem> cafetItemFromJson(String str) => List<CafetItem>.from(json.decode(str).map((x) => CafetItem.fromJson(x)));

String cafetItemToJson(List<CafetItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CafetItem {
  CafetItem({
    this.id,
    this.name,
    this.description,
    this.imageFileName,
    this.type,
    this.price,
    this.day,
  });

  int id;
  String name;
  String description;
  dynamic imageFileName;
  CafetItemType type;
  double price;
  String day;

  factory CafetItem.fromJson(Map<String, dynamic> json) => CafetItem(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    imageFileName: json["image_file_name"],
    type: typeValues.map[json["type"]],
    price: json["price"].toDouble(),
    day: json["day"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image_file_name": imageFileName,
    "type": typeValues.reverse[type],
    "price": price,
    "day": day,
  };
}

enum CafetItemType { REPAS, DESSERT, BOISSON }

final typeValues = EnumValues({
  "Boisson": CafetItemType.BOISSON,
  "Dessert": CafetItemType.DESSERT,
  "Repas": CafetItemType.REPAS
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
