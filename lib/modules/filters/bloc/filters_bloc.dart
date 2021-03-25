import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'filters_event.dart';
part 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(FiltersInitialState(filter: "Nothing"));

  @override
  Stream<FiltersState> mapEventToState(
    FiltersEvent event,
  ) async* {
    if (event is FilterInitEvent) {
      yield FiltersInitialState(filter: "");
    } else if (event is FilterChangeEvent) {
      yield FiltersDataState(filter: event.filterName);
    }
  }
}
