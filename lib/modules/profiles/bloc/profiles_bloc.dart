import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_search/modules/profiles/models/profile.dart';
import 'package:github_search/modules/profiles/repositories/profile_repository.dart';
import 'package:meta/meta.dart';

part 'profiles_event.dart';
part 'profiles_state.dart';

class ProfilesBloc extends Bloc<ProfilesEvent, ProfilesState> {
  final ProfilesRepository profilesRepository;

  ProfilesBloc({@required this.profilesRepository}) : super(ProfilesFetchInProgressState());

  @override
  Stream<ProfilesState> mapEventToState(
    ProfilesEvent event,
  ) async* {
    if (event is FetchProfilesEvent) {
      yield* _mapFetchProfilesEventToState();
    }
  }

  Stream<ProfilesState> _mapFetchProfilesEventToState() async* {
    try {
      yield ProfilesFetchInProgressState();
      final profiles = await this.profilesRepository.getProfiles();
      yield ProfilesFetchSuccessState(profiles: profiles ?? []);
    } catch (e) {
      yield ProfilesFetchErrorState();
    }
  }
}
