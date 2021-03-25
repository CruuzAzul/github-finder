import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/modules/profiles/bloc/profiles_bloc.dart';
import 'package:github_search/modules/profiles/widgets/profile_api_card.dart';

class ProfilesList extends StatelessWidget {
  const ProfilesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageHome = Image.asset(
      'assets/images/img_home.png',
      width: 300,
      fit: BoxFit.fitHeight,
    );

    final imageError = Image.asset(
      'assets/images/img_error.png',
      width: 300,
      fit: BoxFit.fitHeight,
    );

    final imageEmpty = Image.asset(
      'assets/images/img_empty.png',
      width: 300,
      fit: BoxFit.fitHeight,
    );

    return Container(
      child: BlocBuilder<ProfilesBloc, ProfilesState>(
        builder: (context, state) {
          if (state is ProfilesInitialeState) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  imageHome,
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
                  imageError,
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
            return Column(
              children: [
                SizedBox(height: 200),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          }

          final profiles = (state as ProfilesFetchSuccessState).profiles;

          return profiles.isNotEmpty
              ? Flexible(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: profiles.length,
                    itemBuilder: (_, index) {
                      return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: profiles.length != null
                              ? ProfileApiCard(
                                  profile: profiles[index],
                                )
                              : Text("0"));
                    },
                  ),
                )
              : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(height: 100),
                  imageEmpty,
                  SizedBox(height: 40),
                  Text(
                    'No results found !',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                ]);
        },
      ),
    );
  }
}
