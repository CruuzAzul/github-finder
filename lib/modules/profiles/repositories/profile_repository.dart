import 'dart:convert';
import 'package:github_search/blocs/profiles/models/profile.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

const kApiBaseUrl = 'https://api.punkapi.com/v2';
const kBeerResource = 'beers';

@immutable
class ProfilesRepository {
  final String text;

  ProfilesRepository({@required this.text}) : assert(text != null);

  Future<List<Profile>> getProfiles({
    int pageNumber = 1,
    int itemsPerPage = 10,
  }) async {
    print(text);
    try {
      Response response = await Dio().get("https://www.google.com");
      print(response.statusCode);
    } catch (e) {
      print(e);
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
