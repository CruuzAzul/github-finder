import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class SearchProfileLabel extends StatelessWidget {
  const SearchProfileLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is! SearchDataChange) {
          return SizedBox(
            height: 20,
          );
        }

        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(
            left: 20,
            top: 10,
            bottom: 10,
          ),
          child: RichText(
              text: TextSpan(
            text: 'Résultats de recherche pour ',
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text: state.text,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' :'),
            ],
          )),
        );
      },
    );
  }
}
