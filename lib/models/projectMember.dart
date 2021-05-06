import 'dart:convert';

import 'package:assoesaip_flutter/models/user.dart';

List<ProjectMember> projectMemberFromJson(String str) => List<ProjectMember>.from(json.decode(str).map((x) => ProjectMember.fromJson(x)));

String projectMemberToJson(List<ProjectMember> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectMember {
  ProjectMember({
    this.id,
    this.user,
    this.role,
    this.introduction,
    this.admin,
    this.orderPosition,
  });

  int? id;
  User? user;
  String? role;
  String? introduction;
  bool? admin;
  int? orderPosition;

  factory ProjectMember.fromJson(Map<String, dynamic> json) => ProjectMember(
    id: json["id"],
    user: User.fromJson(json["user"]),
    role: json["role"],
    introduction: json["introduction"],
    admin: json["admin"],
    orderPosition: json["order_position"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user!.toJson(),
    "role": role,
    "introduction": introduction,
    "admin": admin,
    "order_position": orderPosition,
  };
}