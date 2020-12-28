import 'dart:convert';

import 'package:assoesaip_flutter/models/article.dart';
import 'package:assoesaip_flutter/models/news.dart';
import 'package:assoesaip_flutter/models/project.dart';
import 'package:assoesaip_flutter/models/projectCategory.dart';
import 'package:assoesaip_flutter/models/projectMember.dart';
import 'package:assoesaip_flutter/models/projectPage.dart';
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

Future<List<Project>> getCategoryProjects(int categId) async {
  final response = await Requests.get('$url/project-category/$categId');
  if (response.hasError) {
    return null;
  }

  var jsonArray = jsonDecode(response.content()) as List;

  return jsonArray.map((e) => Project.fromJson(e)).toList();
}

Future<List<News>> getCategoryNews(int categId) async {
  final response = await Requests.get('$url/project-category/$categId/news');
  if (response.hasError) {
    return null;
  }

  var jsonArray = jsonDecode(response.content()) as List;

  return jsonArray.map((e) => News.fromJson(e)).toList();
}

Future<Article> getArticle(int articleId) async {
  final response = await Requests.get('$url/article/$articleId');
  if (response.hasError) {
    return null;
  }

  return articleFromJson(response.content());
}

Future<Project> getProject(int projectId) async {
  final response = await Requests.get('$url/project/$projectId');
  if (response.hasError) {
    return null;
  }

  return projectFromJson(response.content());
}

Future<List<ProjectPage>> getProjectPages(int projectId) async {
  final response = await Requests.get('$url/project/$projectId/pages');
  if (response.hasError) {
    return null;
  }

  var jsonArray = jsonDecode(response.content()) as List;

  return jsonArray.map((e) => ProjectPage.fromJson(e)).toList();
}

Future<List<ProjectMember>> getProjectMembers(int projectId) async {
  final response = await Requests.get('$url/project/$projectId/members');
  if (response.hasError) {
    return null;
  }

  var jsonArray = jsonDecode(response.content()) as List;

  return jsonArray.map((e) => ProjectMember.fromJson(e)).toList();
}

Future<List<News>> getProjectNews(int projectId) async {
  final response = await Requests.get('$url/project/$projectId/news');
  if (response.hasError) {
    return null;
  }

  var jsonArray = jsonDecode(response.content()) as List;

  return jsonArray.map((e) => News.fromJson(e)).toList();
}