import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/modules/blocs.dart';

class DropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FiltersBloc filtersBloc = BlocProvider.of<FiltersBloc>(context);

    return Padding(
      padding: const EdgeInsets.only(right: 30, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Sort by : ",
            style: TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(width: 15,),
          BlocBuilder<FiltersBloc, FiltersState>(
            builder: (context, state) {
              return DropdownButton<String>(
                value: state.filter,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                itemHeight: 50,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold
                ),
                underline: Container(
                  height: 2,
                  color: Colors.amber,
                ),
                onChanged: (String newValue) {
                  filtersBloc.add(FilterChangeEvent(filterName: newValue));
                },
                items: <String>['Nothing', 'Creation date', 'Number of repositories', 'Number of followers']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              );
            }
          ),
        ],
      ),
    );
  }
}
