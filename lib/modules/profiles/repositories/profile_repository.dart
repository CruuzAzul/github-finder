import 'package:github_search/modules/profiles/exceptions/custom_exceptions.dart';
import 'package:github_search/modules/profiles/models/profile.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

@immutable
class ProfilesRepository {
  final String searchText;
  final String filterText;
  String sort;
  final Dio dio;

  ProfilesRepository({@required this.dio, this.searchText, this.filterText}) : assert(dio != null);

  Future<List<Profile>> getProfiles(searchText, filterText) async {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) {
        options.headers["Authorization"] =
            "token " + "";
        return options;
      },
    ));

    switch (filterText) {
      case "Creation date":
        sort = "joined";
        break;
      case "Number of repositories":
        sort = "repositories";
        break;
      case "Number of followers":
        sort = "followers";
        break;
      default:
        sort = "";
    }

    try {
      Response response = await dio.get(
          'https://api.github.com/search/users?q=$searchText+in:login+in:fullname&type=Users&page=0&per_page=10&sort=$sort');
      final parsed = response.data["items"].cast<Map<String, dynamic>>();
      // var dataTest;
      parsed.forEach((elem) => {
            // dataTest = getData(elem["followers_url"]),
            elem["first_follower_img"] = getImgFollower(elem["followers_url"]),
            elem["first_follower_name"] =
                getNameFollower(elem["followers_url"]),
            elem["nb_followers"] = getNbFollowers(elem["followers_url"]),
            elem["nb_stars"] = getNbStars(elem["repos_url"]),
            elem["nb_repo"] = getNbRepos(elem["repos_url"]),
          });
      return (parsed.map<Profile>((json) => Profile.fromJson(json)).toList());
    } catch (e) {
      print("ERROR Fetching data !!");
      return Future.error(
          FetchDataException('error occurred when fetch GitHub API.'));
    }
  }

  // Future<String> getData(String url) async {
  //   try {
  //     Response response = await dio.get(url);
  //     return response.data.isNotEmpty
  //     ? response.data.cast<Map<String, dynamic>>()
  //     : "";
  //   } catch (e) {
  //     print("ERROR !");
  //     return Future.error(FetchDataException(
  //         'error occurred when fetch GitHub API - First follower image.'));
  //   }
  // }

  Future<String> getImgFollower(String url) async {
    try {
      Response response = await dio.get(url);
      return response.data.isNotEmpty ? response.data[0]["avatar_url"] : "";
    } catch (e) {
      print("ERROR Fetching Image first Follower!");
      return Future.error(FetchDataException(
          'error occurred when fetch GitHub API - First follower image.'));
    }
  }

  Future<String> getNameFollower(String url) async {
    try {
      Response response = await dio.get(url);
      return response.data.isNotEmpty ? response.data[0]["login"] : "";
    } catch (e) {
      print("ERROR Fetching Name first Follower!");
      return Future.error(FetchDataException(
          'error occurred when fetch GitHub API - First follower name.'));
    }
  }

  Future<int> getNbFollowers(String url) async {
    try {
      Response response = await dio.get(url);
      return response.data.isNotEmpty ? response.data.length - 1 : 0;
    } catch (e) {
      print("ERROR Fetching Followers number !");
      return Future.error(FetchDataException(
          'error occurred when fetch GitHub API - Followers number.'));
    }
  }

  Future<int> getNbStars(String url) async {
    try {
      Response response = await dio.get(url);
      var counter = 0;
      response.data.forEach((elem) => {counter += elem["stargazers_count"]});
      return response.data.isNotEmpty ? counter : 0;
    } catch (e) {
      print("ERROR Fetching Stars number !");
      return Future.error(FetchDataException(
          'error occurred when fetch GitHub API - Stars number.'));
    }
  }

  Future<int> getNbRepos(String url) async {
    try {
      Response response = await dio.get(url);
      return response.data.isNotEmpty ? response.data.length : 0;
    } catch (e) {
      print("ERROR Fetching Stars number !");
      return Future.error(FetchDataException(
          'error occurred when fetch GitHub API - Stars number.'));
    }
  }
}
