import 'package:flutter/material.dart';

import '../models/profile.dart';
import '../widgets/display_followers.dart';
import '../widgets/display_repository.dart';

class ProfileApiCard extends StatelessWidget {
  final Profile profile;

  const ProfileApiCard({
    Key? key,
    required this.profile,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          AvatarImage(urlImage: profile.avatarUrl),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  profile.login,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.grey[700]),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 20,
                  child: profile.followers != null
                      ? DisplayFollowers(
                          profiles: profile.followers!,
                        )
                      : SizedBox.expand(),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 15,
                  child: profile.repositories != null
                      ? DisplayRepositories(
                          repositories: profile.repositories!,
                        )
                      : SizedBox.expand(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AvatarImage extends StatelessWidget {
  const AvatarImage({
    Key? key,
    required this.urlImage,
  })  : super(key: key);

  final String urlImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
          urlImage,
        ),
      ),
      width: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 5,
          ),
        ],
      ),
    );
  }
}
