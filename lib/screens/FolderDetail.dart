import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koobook_project4/event.dart';
import 'package:koobook_project4/model/book.dart';
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
  void initState() {
    super.initState();
    //folder.addBook(new Book.first("first book"));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(folder.name),
        actions: [
          IconButton(
              icon: Icon(Icons.keyboard_return),
              onPressed: () => widget.testBloc.add(GoToFirstPage())),
        ],
      ),
      body: Stack(children: [
        Container(
          width: size.width,
          height: size.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/2.jpg",
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.hue,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0x6a6a6a).withOpacity(0.1),
                  ),
                ),
              )
            ],
          ),
        ),
        ListView.builder(
            itemCount: folder.books.length,
            itemBuilder: (context, index) {
              final Book book = folder.books[index];
              return Card(
                elevation: 5,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.book),
                  title: Text(book.title),
                  onTap: () {
                    widget.testBloc.add(GoToBookDetail(this.folder, book));
                  },
                ),
              );
            }),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: Icon(Icons.add),
        //inja
        /*onPressed: () {
          setState(() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(20.0)), //this right here
                      child: _report(context));
                });
          });
        },*/
      ),
    );
  }
}
