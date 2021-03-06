part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchInit extends SearchEvent {}

class SearchChange extends SearchEvent {
  final String data;
  SearchChange({required this.data});
}