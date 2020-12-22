import 'dart:convert';

import 'package:assoesaip_flutter/models/article.dart';
import 'package:assoesaip_flutter/models/news.dart';
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