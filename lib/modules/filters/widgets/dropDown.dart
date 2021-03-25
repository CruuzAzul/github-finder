import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  String dropdownValue = 'Score';

  @override
  Widget build(BuildContext context) {
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
          DropdownButton<String>(
            value: dropdownValue,
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
              // setState(() {
              //   dropdownValue = newValue!;
              // });
            },
            items: <String>['Score', 'Number of repositories', 'number of followers']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
