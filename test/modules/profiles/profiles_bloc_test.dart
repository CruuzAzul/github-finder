import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/profiles/blocs/filters/filters_bloc.dart';
import 'package:github_search/modules/profiles/blocs/profiles/profiles_bloc.dart';
import 'package:github_search/modules/profiles/blocs/search/search_bloc.dart';
import 'package:github_search/modules/profiles/exceptions/custom_exceptions.dart';
import 'package:github_search/modules/profiles/models/profile_sort.dart';
import 'package:github_search/modules/profiles/repositories/profile_repository.dart';
import 'package:mockito/mockito.dart';

// ignore: must_be_immutable
class MockProfilesRepository extends Mock implements ProfilesRepository {}

class MockSearchBloc extends Mock implements SearchBloc {}

class MockFiltersBloc extends Mock implements FiltersBloc {}

void main() {
  ProfilesRepository profilesRepository;
  final searchBloc = SearchBloc();
  final filtersBloc = FiltersBloc();

  setUp(() {
    profilesRepository = MockProfilesRepository();
  });

  group('Profiles Bloc Tests', () {
    test('should test initial state', () {
      expect(
        ProfilesBloc(
          profilesRepository: profilesRepository,
          filtersBloc: filtersBloc,
          searchBloc: searchBloc,
        ).state,
        isA<ProfilesInitialeState>(),
      );
    });

    blocTest(
      'emit [] when nothing is called',
      build: () => ProfilesBloc(
        profilesRepository: profilesRepository,
        filtersBloc: filtersBloc,
        searchBloc: searchBloc,
      ),
      expect: () => [],
    );

    blocTest(
      'emit [ProfilesInitialeState] when FetchProfilesEvent is called without search',
      build: () => ProfilesBloc(
          profilesRepository: profilesRepository,
          filtersBloc: filtersBloc,
          searchBloc: searchBloc),
      act: (bloc) async => bloc
          .add(FetchProfilesEvent(searchText: "", sort: ProfileSort.nothing)),
      expect: () => [ProfilesInitialeState()],
    );

    blocTest(
      'emit [ProfilesFetchInProgressState,ProfilesFetchSuccessState] when FetchProfilesEvent is called with a search',
      build: () => ProfilesBloc(
          profilesRepository: profilesRepository,
          filtersBloc: filtersBloc,
          searchBloc: searchBloc),
      act: (bloc) async => bloc.add(
          FetchProfilesEvent(searchText: "Cruz-A", sort: ProfileSort.nothing)),
      expect: () => const <ProfilesState>[
        ProfilesFetchInProgressState(),
        ProfilesFetchSuccessState()
      ],
    );

    blocTest(
      'emit [ProfilesFetchErrorState] when FetchProfilesEvent is called with error',
      build: () {
        when(
          profilesRepository.fetchProfiles(
              searchText: "Cruz-A", sort: ProfileSort.nothing),
        ).thenAnswer((_) => Future.error(FetchDataException()));

        return ProfilesBloc(
            profilesRepository: profilesRepository,
            filtersBloc: filtersBloc,
            searchBloc: searchBloc);
      },
      act: (bloc) async => bloc.add(
          FetchProfilesEvent(searchText: "Cruz-A", sort: ProfileSort.nothing)),
      expect: () => const <ProfilesState>[
        ProfilesFetchInProgressState(),
        ProfilesFetchErrorState(),
      ],
    );
  });
}
