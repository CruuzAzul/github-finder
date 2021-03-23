import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/modules/profiles/repositories/profile_repository.dart';
import 'package:github_search/modules/search/bloc/search_bloc.dart';
import 'package:github_search/modules/search/widgets/formTextField.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GitHub Profiles Finder',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          FormTextField(
            // profilesRepository: ProfilesRepository(
            //   text: "coucou",
            // ),
          ),
          Container(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchInitState) {
                  return Text(state.text.toString());
                } else if (state is SearchDataChange) {
                  return state.text != ""
                  ? Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 30, top: 20),
                    child: RichText(
                        text: TextSpan(
                          text: 'Résultats de recherche pour ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(text: state.text.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ' :'),
                          ],
                        )
                    ),
                  )
                  : Text("");
                } else {
                  return Text("something worng");
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
