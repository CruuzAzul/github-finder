part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState({
    this.text = ""
  });

  final String text;

  @override
  List<Object> get props => [text];
}

class SearchInitState extends SearchState {
  final String text;
  SearchInitState({this.text});
}

class SearchDataChange extends SearchState {
  final String text;
  SearchDataChange({this.text});
}
