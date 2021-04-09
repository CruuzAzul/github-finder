import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/profile.dart';
import '../../models/profile_sort.dart';
import '../../repositories/profile_repository.dart';
import '../blocs.dart';

part 'profiles_event.dart';
part 'profiles_state.dart';

class ProfilesBloc extends Bloc<ProfilesEvent, ProfilesState> {
  final ProfilesRepository profilesRepository;
  final SearchBloc searchBloc;
  final FiltersBloc filtersBloc;

  StreamSubscription? searchBlocSubscription;
  StreamSubscription? filterBlocSubscription;

  void _handleListeningBlocs(_) {
    add(
      FetchProfilesEvent(
        searchText: searchBloc.state.text,
        sort: filtersBloc.state.filter,
        pageNumber: 1,
      ),
    );
  }

  ProfilesBloc({
    required this.profilesRepository,
    required this.searchBloc,
    required this.filtersBloc,
  }) : super(ProfilesInitialeState()) {
    filterBlocSubscription = filtersBloc.stream.listen(_handleListeningBlocs);
    searchBlocSubscription = searchBloc.stream.listen(_handleListeningBlocs);
  }

  @override
  Stream<Transition<ProfilesEvent, ProfilesState>> transformEvents(
    Stream<ProfilesEvent> events,
    TransitionFunction<ProfilesEvent, ProfilesState> transitionFn,
  ) {
    return events
        .debounceTime(
          const Duration(milliseconds: 500),
        )
        .switchMap(transitionFn);
  }

  @override
  void onChange(Change<ProfilesState> change) {
    final nextState = change.nextState;

    if (nextState is ProfilesFetchSuccessState) {
      final profileUpdtated = nextState.profiles!
          .where((profile) =>
              profile.repositories != null && profile.followers != null)
          .toList();
      final profileToUpdate = nextState.profiles!
          .where((profile) =>
              profile.repositories == null && profile.followers == null)
          .toList();

      if (profileToUpdate.isNotEmpty) {
        add(
          FetchProfilesAdditionalDataEvent(
              profileToUpdate: profileToUpdate,
              profileUpdated: profileUpdtated),
        );
      }
    }

    super.onChange(change);
  }

  @override
  Stream<ProfilesState> mapEventToState(
    ProfilesEvent event,
  ) async* {
    final currentState = state;
    if (event is FetchProfilesEvent && !_hasReachedMax(currentState)) {
      yield* _mapFetchProfilesEventToState(
          event.searchText, event.sort, event.pageNumber);
    }

    if (event is FetchProfilesAdditionalDataEvent) {
      yield* _mapFetchProfilesAdditionalDataEventToState(
          event.profileToUpdate, event.profileUpdated);
    }
  }

  Stream<ProfilesState> _mapFetchProfilesEventToState(
      String? searchText, ProfileSort? sort, int pageNumber) async* {
    final currentState = state;
    try {
      if (searchText == "") {
        yield ProfilesInitialeState();
      } else {
        // Fix - Problem here is that the InProgressState will appear only one time
        if (currentState.profiles == null) {
          yield ProfilesFetchInProgressState();
        }
        final profiles = await this.profilesRepository.fetchProfiles(
              searchText: searchText,
              sort: sort,
              pageNumber: pageNumber,
            );
        if (pageNumber == 1) {
          yield ProfilesFetchSuccessState(
              profiles: profiles,
              hasReachedMax: false,
              pageNumber: pageNumber + 1);
        } else {
          yield profiles!.isEmpty
              ? ProfilesFetchSuccessState(
                  profiles: currentState.profiles,
                  hasReachedMax: true,
                  pageNumber: pageNumber)
              : ProfilesFetchSuccessState(
                  profiles: currentState.profiles! + profiles,
                  hasReachedMax: false,
                  pageNumber: pageNumber + 1);
        }
      }
    } catch (e) {
      yield ProfilesFetchErrorState();
    }
  }

  Stream<ProfilesState> _mapFetchProfilesAdditionalDataEventToState(
      List<Profile> profileToUpdate, List<Profile> profileUpdated) async* {
    final currentState = state;
    try {
      final List<Profile> updatedProfiles = await Future.wait(
        profileToUpdate.map(
          (profile) => this.profilesRepository.fetchAdditionalData(profile),
        ),
      );

      yield ProfilesFetchSuccessState(
        profiles: profileUpdated + updatedProfiles,
        hasReachedMax: false,
        pageNumber: currentState.pageNumber,
      );
    } catch (e) {
      // maybe, this case should throw an error silently.
      yield ProfilesFetchErrorState();
    }
  }

  bool _hasReachedMax(ProfilesState state) =>
      state is ProfilesFetchSuccessState &&
      state.hasReachedMax &&
      state.pageNumber <= 100; // Only the first 1000 search results are available

  @override
  Future<void> close() {
    searchBlocSubscription?.cancel();
    filterBlocSubscription?.cancel();

    return super.close();
  }
}
