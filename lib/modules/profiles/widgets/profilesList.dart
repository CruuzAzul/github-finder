import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/modules/profiles/bloc/profiles_bloc.dart';
import 'package:github_search/modules/profiles/widgets/profile_api_card.dart';

class ProfilesList extends StatelessWidget {
  const ProfilesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<ProfilesBloc, ProfilesState>(
        builder: (context, state) {
          if (state is ProfilesInitialeState) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  Image.network(
                    "https://git-user-assignment.herokuapp.com/images/octocat.png",
                    width: 300,
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Enter a name in the search bar to start !',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                ]);
          }

          if (state is ProfilesFetchErrorState) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  Image.network(
                    "https://www.pngkey.com/png/detail/442-4423751_github-octocat-png-github-inspectocat-896-github-hack.png",
                    width: 300,
                  ),
                  SizedBox(height: 40),
                  Text(
                    'An error occurred ! Please retry later !',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                ]);
          }

          if (state is ProfilesFetchInProgressState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final profiles = (state as ProfilesFetchSuccessState).profiles;

          return Flexible(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: profiles.length,
              itemBuilder: (_, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: ProfileApiCard(
                    profile: profiles[index],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
