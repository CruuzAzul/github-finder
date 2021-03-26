import 'package:flutter/material.dart';

import '../models/profile.dart';
import '../widgets/additional_label.dart';

class DisplayFollowers extends StatelessWidget {
  final List<Profile> profiles;

  DisplayFollowers({@required this.profiles}) : assert(profiles != null);

  @override
  Widget build(BuildContext context) {
    if (profiles.isEmpty) {
      return AdditionalLabel(
        label: 'No followers',
      );
    }

    final first = profiles.first;
    return Row(
      children: [
        Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              first.avatarUrl,
              width: 25,
            ),
          ),
          SizedBox(
            width: 4,
          ),
          AdditionalLabel(
            label: first.login,
          ),
        ]),
        if (profiles.length > 1)
          AdditionalLabel(
            label: ' +  ${(profiles.length - 1).toString()}',
          ),
        SizedBox(
          width: 4,
        ),
        AdditionalLabel(
          label: 'follower${profiles.length > 1 ? 's' : ''}',
        )
      ],
    );
  }
}
