import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/modules/filters/bloc/filters_bloc.dart';
import 'package:github_search/screens/HomeScreen.dart';

import 'modules/search/bloc/search_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Finder',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
        BlocProvider<FiltersBloc>(
          create: (context) => FiltersBloc(),
        )
      ],
        child: HomeScreen(),
      ),
    );
  }
}
