import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/modules/profiles/profiles.dart';

final searchBloc = SearchBloc();
final filterBloc = FiltersBloc();

class HomeScreen extends StatelessWidget {
  final Dio dio;

  HomeScreen({Key key, @required this.dio})
      : assert(dio != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GitHub Profiles Finder',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<SearchBloc>(
            create: (context) => searchBloc,
          ),
          BlocProvider<FiltersBloc>(
            create: (context) => filterBloc,
          ),
          BlocProvider(
            create: (context) => ProfilesBloc(
              profilesRepository: ProfilesRepository(
                // TODO: manage once at application startup => Maybe introduce get_it to Mickael
                dio: dio,
              ),
              searchBloc: searchBloc,
              filtersBloc: filterBloc,
            ),
          )
        ],
        child: Container(
          color: Colors.grey[100],
          child: Column(
            children: [
              SearchField(),
              SortDropDown(),
              SearchProfileLabel(),
              ProfilesList(),
            ],
          ),
        ),
      ),
    );
  }
}
