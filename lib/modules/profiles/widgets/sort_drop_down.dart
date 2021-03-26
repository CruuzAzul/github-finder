import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/modules/profiles/blocs/blocs.dart';

import '../models/profile_sort.dart';

final _profileSortButtons = const <ProfileSort>[
  ProfileSort.nothing,
  ProfileSort.joined,
  ProfileSort.repositories,
  ProfileSort.followers
].map<DropdownMenuItem<ProfileSort>>((ProfileSort value) {
  return DropdownMenuItem<ProfileSort>(
    value: value,
    child: Text(
      value.displayProfileSort(),
    ),
  );
}).toList();

class SortDropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Sort by : ",
            style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 15,
          ),
          BlocBuilder<FiltersBloc, FiltersState>(builder: (context, state) {
            return DropdownButton<ProfileSort>(
              value: state.filter,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              itemHeight: 50,
              style: TextStyle(
                  color: Colors.grey[700], fontWeight: FontWeight.bold),
              underline: Container(
                height: 2,
                color: Colors.amber,
              ),
              onChanged: (newValue) {
                context
                    .read<FiltersBloc>()
                    .add(FilterChangeEvent(filterName: newValue));
              },
              items: _profileSortButtons,
            );
          }),
        ],
      ),
    );
  }
}
