import 'dart:convert';
import 'package:github_search/modules/profiles/exceptions/custom_exceptions.dart';
import 'package:github_search/modules/profiles/models/profile.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

const kApiBaseUrl = 'https://api.punkapi.com/v2';
const kBeerResource = 'beers';

@immutable
class ProfilesRepository {
  // final String text;

  // ProfilesRepository({@required this.text}) : assert(text != null);

  Future<List<Profile>> getProfiles() async {
    print("-----------------");
    print("Passage dans la fonction getProfiles");
    print("-----------------");
    try {
      Response response = await Dio().get("https://api.github.com/search/users?q=Cruz-A+in:login+in:fullname&type=Users&page=0&per_page=10&sort=score");
      print("-----------------");
      print(response.data.runtimeType);
      print("-----------------");
      final parsed = jsonDecode(response.data.items).cast<Map<String, dynamic>>();
      return parsed.map<Profile>((json) => Profile.fromJson(json)).toList();
    } catch (e) {
      return Future.error(FetchDataException(
          'error occurred when fetch GitHub API.'));
    }
    // final response = await client.get(
    //     '$kApiBaseUrl/$kBeerResource?page=$pageNumber&per_page=$itemsPerPage');

    // if (response.statusCode != 200) {
    //   return Future.error(FetchDataException(
    //       'error occurred when fetch GitHub API: {$response.statusCode}'));
    // }

    // final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();

    // return parsed.map<Profile>((json) => Profile.fromJson(json)).toList();
  }
}
