import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    this.login,
    this.avatarUrl,
    this.url,
    this.htmlUrl,
    this.followersUrl,
    this.starredUrl,
    this.reposUrl,
  });

  String login;
  String avatarUrl;
  String url;
  String htmlUrl;
  String followersUrl;
  String starredUrl;
  String reposUrl;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        login: json["login"],
        avatarUrl: json["avatar_url"],
        url: json["url"],
        htmlUrl: json["html_url"],
        followersUrl: json["followers_url"],
        starredUrl: json["starred_url"],
        reposUrl: json["repos_url"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "avatar_url": avatarUrl,
        "url": url,
        "html_url": htmlUrl,
        "followers_url": followersUrl,
        "starred_url": starredUrl,
        "repos_url": reposUrl,
      };

  Profile copyWith(
      {int login,
      String avatarUrl,
      String url,
      String htmlUrl,
      String followersUrl,
      String starredUrl,
      String reposUrl}) {
    return Profile(
      login: login ?? this.login,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      url: url ?? this.url,
      htmlUrl: htmlUrl ?? this.htmlUrl,
      followersUrl: followersUrl ?? this.followersUrl,
      starredUrl: starredUrl ?? this.starredUrl,
      reposUrl: reposUrl ?? this.reposUrl,
    );
  }
}
