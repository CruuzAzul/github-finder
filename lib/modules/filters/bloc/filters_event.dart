part of 'filters_bloc.dart';

abstract class FiltersEvent extends Equatable {
  const FiltersEvent();

  @override
  List<Object> get props => [];
}

class FilterInitEvent extends FiltersEvent {}

class FilterChangeEvent extends FiltersEvent {
  final String filterName;
  FilterChangeEvent({@required this.filterName});
}