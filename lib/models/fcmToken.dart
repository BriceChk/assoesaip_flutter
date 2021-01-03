import 'dart:convert';

FcmToken fcmTokenFromJson(String str) => FcmToken.fromJson(json.decode(str));

String fcmTokenToJson(FcmToken data) => json.encode(data.toJson());

class FcmToken {
  FcmToken({
    this.instanceId,
    this.token,
  });

  String instanceId;
  String token;

  factory FcmToken.fromJson(Map<String, dynamic> json) => FcmToken(
    instanceId: json["instance_id"],
    token: json["token"],
  );

  factory FcmToken.fromTokenString(String tokenString) => FcmToken(
    instanceId: tokenString.split(':')[0],
    token: tokenString,
  );

  Map<String, dynamic> toJson() => {
    "instance_id": instanceId,
    "token": token,
  };
}
