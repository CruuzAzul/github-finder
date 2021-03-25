import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_search/modules/blocs.dart';
import 'package:github_search/modules/profiles/models/profile.dart';
import 'package:github_search/modules/profiles/repositories/profile_repository.dart';
import 'package:github_search/modules/search/bloc/search_bloc.dart';
import 'package:meta/meta.dart';

part 'profiles_event.dart';
part 'profiles_state.dart';

class ProfilesBloc extends Bloc<ProfilesEvent, ProfilesState> {
  final ProfilesRepository profilesRepository;
  // final SearchBloc searchBloc;
  StreamSubscription searchBlocSubscription;

  ProfilesBloc({@required this.profilesRepository, SearchBloc searchBloc}) : super(ProfilesInitialeState()) {
    if (searchBloc != null) {
      searchBlocSubscription = searchBloc.stream.listen((state) {
        add(FetchProfilesEvent(state.text));
    });
  }
}

  // ProfilesBloc({@required this.profilesRepository, SearchBloc searchBloc}) : super(ProfilesFetchInProgressState());
  
  @override
  Stream<ProfilesState> mapEventToState(
    ProfilesEvent event,
  ) async* {
    if (event is FetchProfilesEvent) {
      yield* _mapFetchProfilesEventToState(event.searchText);
    }
  }

  Stream<ProfilesState> _mapFetchProfilesEventToState(searchText) async* {
    try {
      if (searchText == "") {
        yield ProfilesInitialeState();
      } else {
        yield ProfilesFetchInProgressState();
        final profiles = await this.profilesRepository.getProfiles(searchText);
        yield ProfilesFetchSuccessState(profiles: profiles ?? []);
      }
    } catch (e) {
      yield ProfilesFetchErrorState();
    }
  }

  @override
  // ignore: missing_return
  Future<void> close() {
    if (searchBlocSubscription != null ) {
      searchBlocSubscription.cancel();
      return super.close();
    }
  }
}
