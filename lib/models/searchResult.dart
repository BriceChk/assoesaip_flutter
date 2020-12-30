import 'dart:convert';

List<SearchResult> searchResultFromJson(String str) => List<SearchResult>.from(json.decode(str).map((x) => SearchResult.fromJson(x)));

String searchResultToJson(List<SearchResult> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchResult {
  SearchResult({
    this.name,
    this.type,
    this.url,
    this.id,
    this.description,
  });

  String name;
  String type;
  String url;
  int id;
  String description;

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
    name: json["name"],
    type: json["type"],
    url: json["url"],
    id: json["id"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
    "url": url,
    "id": id,
    "description": description,
  };
}
