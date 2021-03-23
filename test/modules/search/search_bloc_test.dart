import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/blocs.dart';

void main() {
  group('Search Bloc Tests', () {
    test('should test initial state', () {
      expect(
        SearchBloc().state,
        isA<SearchInitState>(),
      );
    });

    blocTest(
      'emit [] when nothing is called',
      build: () => SearchBloc(),
      expect: () => [],
    );

    blocTest(
      'emit [SearchInit] when SearchInit is called', 
      build: () => SearchBloc(),
      act: (bloc) async => bloc.add(SearchInit()),
      expect: () => [SearchInitState(text: "")],
    );

    blocTest(
      'emit [SearchChange] when SearchInit is called', 
      build: () => SearchBloc(),
      act: (bloc) async => bloc.add(SearchChange(data: "test_txt")),
      expect: () => [SearchDataChange(text: "test_txt")],
    );
  });
}