import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:github_search/screens/homeScreen.dart';

final dio = Dio()
  ..interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options) {
        options.headers['Authorization'] =
            'token ${const String.fromEnvironment('GITHUB_TOKEN')}';
        return options;
      },
    ),
  );

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Finder',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(
        dio: dio,
      ),
    );
  }
}
