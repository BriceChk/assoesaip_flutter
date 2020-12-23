import 'dart:convert';

import 'package:assoesaip_flutter/models/news.dart';
import 'package:assoesaip_flutter/models/projectCategory.dart';
import 'package:assoesaip_flutter/models/user.dart';
import 'package:requests/requests.dart';

String url = 'https://asso-esaip.bricechk.fr/api';

Future<User> getUser() async {
  final response = await Requests.get('$url/profile');
  if (response.hasError) {
    return null;
  }
  return userFromJson(response.content());
}

Future<List<News>> getNews() async {
  final response = await Requests.get('$url/news');
  if (response.hasError) {
    return null;
  }

  var jsonArray = jsonDecode(response.content()) as List;

  return jsonArray.map((e) => News.fromJson(e)).toList();
}

Future<List<News>> getStarredNews() async {
  final response = await Requests.get('$url/news/starred');
  if (response.hasError) {
    return null;
  }

  var jsonArray = jsonDecode(response.content()) as List;

  return jsonArray.map((e) => News.fromJson(e)).toList();
}

Future<List<ProjectCategory>> getProjectCategories() async {
  final response = await Requests.get('$url/project-category');
  if (response.hasError) {
    return null;
  }

  var jsonArray = jsonDecode(response.content()) as List;

  return jsonArray.map((e) => ProjectCategory.fromJson(e)).toList();
}