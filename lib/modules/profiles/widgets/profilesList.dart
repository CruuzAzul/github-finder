import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/modules/profiles/bloc/profiles_bloc.dart';

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
        },
      ),
    );
  }
}