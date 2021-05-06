class ProjectSocialInfo {
  ProjectSocialInfo({
    this.facebookUrl,
    this.instagramName,
    this.youtubeUrl,
    this.discordUrl,
    this.twitterName,
    this.snapchatName,
  });

  String? facebookUrl;
  String? instagramName;
  String? youtubeUrl;
  String? discordUrl;
  String? twitterName;
  String? snapchatName;

  factory ProjectSocialInfo.fromJson(Map<String, dynamic> json) => ProjectSocialInfo(
    facebookUrl: json["fb"],
    instagramName: json["insta"],
    youtubeUrl: json["yt"],
    discordUrl: json["discord"],
    twitterName: json["twt"],
    snapchatName: json["snap"],
  );

  Map<String, dynamic> toJson() => {
    "fb": facebookUrl,
    "insta": instagramName,
    "yt": youtubeUrl,
    "discord": discordUrl,
    "twt": twitterName,
    "snap": snapchatName,
  };
}