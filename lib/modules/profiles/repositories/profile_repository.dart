import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../exceptions/custom_exceptions.dart';
import '../models/profile.dart';
import '../models/profile_sort.dart';
import '../models/repository.dart';

@immutable
class ProfilesRepository {
  final Dio dio;

  ProfilesRepository({
    @required this.dio,
  }) : assert(dio != null);

  Future<List<Profile>> fetchProfiles({
    String searchText = '',
    ProfileSort sort,
  }) async {
    try {
      Response response = await dio.get(
        'https://api.github.com/search/users?q=$searchText+in:login+in:fullname&type=Users&page=0&per_page=10&sort=${sort.profileSortToString()}',
      );

      final parsed = response.data["items"].cast<Map<String, dynamic>>();

      return parsed.map<Profile>((json) => Profile.fromJson(json)).toList();
    } catch (e) {
      return Future.error(
          FetchDataException('error occurred when fetch GitHub API.'));
    }
  }

  Future<Profile> fetchAdditionalData(Profile profile) async {
    final additionalData = await Future.wait([
      fetchFollowers(profile.followersUrl),
      fetchRepositories(profile.repositoriesUrl),
    ]);

    return profile.copyWith(
      followers: additionalData[0] as List<Profile>,
      repositories: additionalData[1] as List<Repository>,
    );
  }

  Future<List<Profile>> fetchFollowers(String url) async {
    try {
      Response response = await dio.get(url);
      final parsed = response.data.cast<Map<String, dynamic>>();

      return parsed.map<Profile>((json) => Profile.fromJson(json)).toList();
    } catch (e) {
      return Future.error(
        FetchDataException('An error occurred when fetching followers'),
      );
    }
  }

  Future<List<Repository>> fetchRepositories(String url) async {
    try {
      Response response = await dio.get(url);
      final parsed = response.data.cast<Map<String, dynamic>>();

      return parsed
          .map<Repository>((json) => Repository.fromJson(json))
          .toList();
    } catch (e) {
      return Future.error(
        FetchDataException('An error occurred when fetching repositories'),
      );
    }
  }
}
