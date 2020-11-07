import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koobook_project4/event.dart';
import 'package:koobook_project4/model/folder.dart';
import '../bloc.dart';

class FolderDetail extends StatefulWidget {
  TestBloc  testBloc;
  final Folder folder;
  FolderDetail(this.testBloc, this.folder);

  @override
  _FolderDetailState createState() => _FolderDetailState(folder);
}

class _FolderDetailState extends State<FolderDetail> {
  final Folder folder;
  _FolderDetailState(this.folder);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(folder.name),
        actions: [
          IconButton(
              icon: Icon(Icons.keyboard_return),
              onPressed: () => widget.testBloc.add(GoToFirstPage())),
        ],
      ),
    );
  }
}
