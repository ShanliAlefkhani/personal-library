import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koobook_project4/model/folder.dart';
import '../bloc.dart';
import '../event.dart';
import '../hexColor.dart';

class SearchPage extends StatefulWidget {
  TestBloc testBloc;
  final Folder folder;

  SearchPage(this.testBloc, this.folder);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Color _color1 = HexColor("#de1b1b");
  String s;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: _color1,
        title: Text("Search Books"),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 80, left: 20, right: 20),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.blueGrey.shade100,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: TextField(
          keyboardType: TextInputType.name,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            //prefixText: "Search",
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          onSubmitted: (String value) {
            try {
              widget.testBloc.add(GoToResultsPage(widget.folder, value));
            } catch (exception) {}
          },
        ),
      ),
    );
  }
}
