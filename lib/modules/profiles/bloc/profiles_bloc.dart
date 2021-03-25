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
  String currentSearch = "";
  String currentFilter  = "Nothing";

  StreamSubscription searchBlocSubscription;
  StreamSubscription filterBlocSubscription;

  ProfilesBloc({@required this.profilesRepository, SearchBloc searchBloc, FiltersBloc filterBloc})
      : super(ProfilesInitialeState()) {

    if (filterBloc != null) {
      filterBlocSubscription = filterBloc.stream.listen((state) { 
        currentFilter = state.filter;
        if (searchBloc != null && currentSearch != "") {
          add(FetchProfilesEvent(searchText: currentSearch, filterText: currentFilter));
        }
      });
    }

    if (searchBloc != null) {
      searchBlocSubscription = searchBloc.stream.listen((state) {
        currentSearch = state.text;
        add(FetchProfilesEvent(searchText: currentSearch, filterText: currentFilter));
      });
    }
  }

  @override
  Stream<ProfilesState> mapEventToState(
    ProfilesEvent event,
  ) async* {
    if (event is FetchProfilesEvent) {
      yield* _mapFetchProfilesEventToState(event.searchText, event.filterText);
    }
  }

  Stream<ProfilesState> _mapFetchProfilesEventToState(searchText, filterText) async* {
    try {
      if (searchText == "") {
        yield ProfilesInitialeState();
      } else {
        yield ProfilesFetchInProgressState();
        final profiles = await this.profilesRepository.getProfiles(searchText, filterText);
        yield ProfilesFetchSuccessState(profiles: profiles ?? []);
      }
    } catch (e) {
      yield ProfilesFetchErrorState();
    }
  }

  @override
  // ignore: missing_return
  Future<void> close() {
    if (searchBlocSubscription != null) {
      searchBlocSubscription.cancel();
      return super.close();
    }
    if (filterBlocSubscription != null) {
      filterBlocSubscription.cancel();
      return super.close();
    }
  }
}
