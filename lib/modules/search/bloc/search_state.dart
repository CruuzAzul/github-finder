part of 'search_bloc.dart';

abstract class SearchState {}

class SearchInitState extends SearchState {
  final String text;
  SearchInitState({this.text});
}

class SearchDataChange extends SearchState {
  final String text;
  SearchDataChange({this.text});
}
