import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                onChanged: (value) => context.read<SearchBloc>().add(
                      value == '' ? SearchInit() : SearchChange(data: value),
                    ),
              ),
            ),
          ],
        ));
  }
}
