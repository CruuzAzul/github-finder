import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'repository.dart';

@immutable
class Profile extends Equatable {
  final String login;
  final String avatarUrl;
  final String followersUrl;
  final String repositoriesUrl;
  final List<Profile> followers;
  final List<Repository> repositories;

  Profile({
    @required this.login,
    @required this.avatarUrl,
    @required this.followersUrl,
    @required this.repositoriesUrl,
    this.followers,
    this.repositories,
  })  : assert(login != null),
        assert(avatarUrl != null);

  Profile.fromJson(Map<String, dynamic> json)
      : this(
          login: json["login"],
          avatarUrl: json["avatar_url"],
          followersUrl: json["followers_url"],
          repositoriesUrl: json["repos_url"],
        );

  Profile copyWith({
    int login,
    String avatarUrl,
    String followersUrl,
    String repositoriesUrl,
    List<Profile> followers,
    List<Repository> repositories,
  }) {
    return Profile(
      login: login ?? this.login,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      followersUrl: followersUrl ?? this.followersUrl,
      repositoriesUrl: repositoriesUrl ?? this.repositoriesUrl,
      followers: followers ?? this.followers,
      repositories: repositories ?? this.repositories,
    );
  }

  @override
  List<Object> get props => [login, avatarUrl, followers, repositories];
}