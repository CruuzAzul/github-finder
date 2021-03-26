import 'package:meta/meta.dart';

@immutable
class Repository {
  final String name;
  final int stars;

  Repository({@required this.name, @required this.stars})
      : assert(name != null),
        assert(stars != null);

  Repository.fromJson(Map<String, dynamic> json)
      : this(
          name: json["name"],
          stars: json["stargazers_count"],
        );

  Repository copyWith({
    String name,
    int stars,
  }) {
    return Repository(
      name: name ?? this.name,
      stars: stars ?? this.stars,
    );
  }
}
