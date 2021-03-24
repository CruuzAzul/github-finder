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
          if (state is ProfilesFetchErrorState) {
            return Center(
              child: Text('An error occurred'),
            );
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
