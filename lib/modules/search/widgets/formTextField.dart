import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/modules/search/bloc/search_bloc.dart';

class FormTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SearchBloc searchBloc = BlocProvider.of<SearchBloc>(context);
    
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.amber),
                    borderRadius: BorderRadius.circular(40),
                    ),
                  hintText: 'Enter user here...',
                  contentPadding: EdgeInsets.all(15),
                ),
                onChanged: (value) => searchBloc.add(SearchChange(data: value)),
              ),
            ),
          ],
        ));
  }
}
