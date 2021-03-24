import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    this.login,
    this.avatarUrl,
    this.url,
    this.htmlUrl,
    this.firstFollowerImage,
    this.firstFollowerName,
    this.followersNumber,
    this.starsNumber,
    this.reposNumber,
  });

  String login;
  String avatarUrl;
  String url;
  String htmlUrl;
  Future<String> firstFollowerImage;
  Future<String> firstFollowerName;
  Future<int> followersNumber;
  Future<int> starsNumber;
  Future<int> reposNumber;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        login: json["login"],
        avatarUrl: json["avatar_url"],
        url: json["url"],
        firstFollowerImage: json["first_follower_img"],
        firstFollowerName: json["first_follower_name"],
        followersNumber: json["nb_followers"],
        starsNumber: json["nb_stars"],
        reposNumber: json["nb_repo"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "avatar_url": avatarUrl,
        "url": url,
        "first_follower_img": firstFollowerImage,
        "first_follower_name": firstFollowerName,
        "nb_followers": followersNumber,
        "nb_stars": starsNumber,
        "nb_repo": reposNumber,
      };

  Profile copyWith(
      {int login,
      String avatarUrl,
      String url,
      String firstFollowerImage,
      String firstFollowerName,
      String followersNumber,
      String starsNumber,
      String reposNumber}) {
    return Profile(
      login: login ?? this.login,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      url: url ?? this.url,
      firstFollowerImage: firstFollowerImage ?? this.firstFollowerImage,
      firstFollowerName: firstFollowerName ?? this.firstFollowerName,
      followersNumber: followersNumber ?? this.followersNumber,
      starsNumber: starsNumber ?? this.starsNumber,
      reposNumber: reposNumber ?? this.reposNumber,
    );
  }
}
