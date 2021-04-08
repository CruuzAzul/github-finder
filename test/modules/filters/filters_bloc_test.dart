import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/profiles/blocs/filters/filters_bloc.dart';
import 'package:github_search/modules/profiles/models/profile_sort.dart';

void main() {
  
  group('Search Bloc Tests', () {
    test('should test initial state', () {
      expect(
        FiltersBloc().state,
        isA<FiltersInitialState>(),
      );
    });

    blocTest(
      'emit [] when nothing is called',
      build: () => FiltersBloc(),
      expect: () => [],
    );

    blocTest(
      'emit [FiltersInitialState] when FilterInitEvent is called',
      build: () => FiltersBloc(),
      act: (bloc) async => bloc.add(FilterInitEvent()),
      expect: () => [FiltersInitialState()],
    );

    blocTest(
      'emit [SearchChange] when FilterChangeEvent is called',
      build: () => FiltersBloc(),
      act: (bloc) async => bloc.add(FilterChangeEvent(filterName: ProfileSort.nothing)),
      expect: () => [FiltersDataState(filter: ProfileSort.nothing)],
    );
  });
}
