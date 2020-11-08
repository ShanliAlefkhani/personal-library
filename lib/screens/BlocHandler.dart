import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koobook_project4/model/book.dart';
import 'package:koobook_project4/model/folder.dart';
import 'package:koobook_project4/screens/FirstPage.dart';
import '../bloc.dart';
import '../state.dart';
import 'BookDetail.dart';
import 'FolderDetail.dart';
import 'ResultsPage.dart';
import 'SearchPage.dart';

class TestingPage extends StatefulWidget {
  @override
  _TestingPageState createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  TestBloc testBloc;

  @override
  void initState() {
    super.initState();
    testBloc = BlocProvider.of<TestBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
          child: BlocBuilder<TestBloc, TestState>(
            builder: (context, state) {
              if (state is Home) {
                return FirstPage(testBloc);
              }
              else if (state is FolderDetailInit) {
                Folder folder = state.folder;
                return FolderDetail(testBloc, folder);
              }
              else if (state is BookDetailInit) {
                Folder folder = state.folder;
                Book book = state.book;
                return BookDetail(testBloc, folder, book);
              }
              else if (state is SearchPageInit) {
                Folder folder = state.folder;
                return SearchPage(testBloc, folder);
              }
              else if (state is ResultsPageInit) {
                Folder folder = state.folder;
                String searchName = state.searchName;
                return ResultsPage(testBloc, folder, searchName);
              }
              else {
                return Scaffold(body: Center(child: Text("loading"),),);
              }
            },
          )
      ),
    );
  }
}