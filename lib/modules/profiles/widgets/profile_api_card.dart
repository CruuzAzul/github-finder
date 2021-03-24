import 'package:flutter/material.dart';
import 'package:github_search/modules/profiles/models/profile.dart';

class ProfileApiCard extends StatelessWidget {
  final Profile profile;

  const ProfileApiCard({
    Key key,
    @required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
          Container(
            margin: EdgeInsets.only(left: 10, right: 30),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  profile.avatarUrl,
                )),
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
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  profile.login,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.grey[700]),
                ),
                FutureBuilder(
                  future:
                      Future.wait([profile.starsNumber, profile.reposNumber]),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.data != null && snapshot.data.isNotEmpty) {
                      var firstHasData =
                          snapshot.data[0] != null && snapshot.data[0] != 0;
                      var secondHasData =
                          snapshot.data[1] != null && snapshot.data[1] != 0;
                      return Row(
                        children: [
                          if (firstHasData)
                            Row(children: [
                              Icon(Icons.star, color: Colors.amber),
                              Text(snapshot.data[0].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[500])),
                            ]),
                          if (firstHasData && secondHasData) Text(" - "),
                          if (secondHasData)
                            Row(children: [
                              Icon(Icons.book, color: Colors.amber),
                              Text(
                                  snapshot.data[1].toString() + " repositories",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[500])),
                            ]),
                          Text("")
                        ],
                      );
                    } else {
                      return Text("");
                    }
                  },
                ),
                FutureBuilder(
                  future: Future.wait([
                    profile.firstFollowerImage,
                    profile.firstFollowerName,
                    profile.followersNumber
                  ]),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.data != null && snapshot.data.isNotEmpty) {
                      var firstHasData = snapshot.data[0] != null &&
                          snapshot.data[0].isNotEmpty;
                      var secondHasData =
                          snapshot.data[1] != null && snapshot.data[1] != 0;
                      var thirdHasData =
                          snapshot.data[2] != null && snapshot.data[2] != 0;
                      if (firstHasData && secondHasData)
                        return Row(
                          children: [
                            if (firstHasData && secondHasData)
                              Row(children: [
                                Text(
                                  " Followers :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.amber),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      snapshot.data[0],
                                      width: 25,
                                    ),
                                  ),
                                ),
                                Text(
                                  snapshot.data[1],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.grey[700]),
                                ),
                              ]),
                            if (thirdHasData)
                              Text(
                                " + " + snapshot.data[2].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.grey[700]),
                              ),
                          ],
                        );
                      return Text("");
                    } else {
                      return Text("");
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
