part of 'filters_bloc.dart';

abstract class FiltersState extends Equatable {
  const FiltersState({
    this.filter = "Nothing"
  });
  
  final String filter;

  @override
  List<Object> get props => [filter];
}

class FiltersInitialState extends FiltersState {
  final String filter;
  FiltersInitialState({this.filter});
}

class FiltersDataState extends FiltersState {
  final String filter;
  FiltersDataState({this.filter});
}