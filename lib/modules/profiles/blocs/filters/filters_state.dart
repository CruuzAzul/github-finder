part of 'filters_bloc.dart';

abstract class FiltersState extends Equatable {
  final ProfileSort? filter;

  const FiltersState({this.filter});

  @override
  List<Object?> get props => [filter];
}

class FiltersInitialState extends FiltersState {
  FiltersInitialState() : super(filter: ProfileSort.nothing);
}

class FiltersDataState extends FiltersState {
  FiltersDataState({ProfileSort? filter}) : super(filter: filter);
}
