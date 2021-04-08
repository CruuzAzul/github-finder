import 'package:flutter/material.dart';

import '../models/repository.dart';
import '../widgets/additional_label.dart';

class DisplayRepositories extends StatelessWidget {
  final List<Repository> repositories;

  DisplayRepositories({required this.repositories});

  @override
  Widget build(BuildContext context) {
    if (repositories.isEmpty) {
      return AdditionalLabel(
        label: 'No repository',
      );
    }

    int stars = repositories
        .map((repo) => repo.stars)
        .reduce((acc, stars) => acc + stars);

    return Row(
      children: [
        Row(children: [
          Transform.translate(
            offset: const Offset(0, -4),
            child: Icon(Icons.star, color: Colors.amber),
          ),
          AdditionalLabel(
            label: stars.toString(),
          ),
        ]),
        SizedBox(
          width: 15,
        ),
        Row(
          children: [
            Transform.translate(
              offset: const Offset(0, -3),
              child: Icon(Icons.book, color: Colors.amber),
            ),
            AdditionalLabel(
              label: '${repositories.length.toString()} repositories',
            ),
          ],
        ),
        Text("")
      ],
    );
  }
}
