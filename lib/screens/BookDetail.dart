import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koobook_project4/model/book.dart';
import 'package:koobook_project4/model/folder.dart';
import '../bloc.dart';
import '../event.dart';
import '../hexColor.dart';

class BookDetail extends StatefulWidget {
  TestBloc  testBloc;
  final Folder folder;
  final Book book;

  BookDetail(this.testBloc, this.folder, this.book);

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {

  Color _color1 = HexColor("#b5af0b");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: _color1,
        title: Text(
          widget.book.title,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.keyboard_return),
              onPressed: () => widget.testBloc.add(GoToFolderDetail(widget.folder))),
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(20),
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.book.image),
                ),
              ),
            ),
          ),
          Text(
            widget.book.authors,
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Text(
            widget.book.publisher,
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                widget.book.description,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
          Text(
            "rate: ${widget.book.rate}",
            style: TextStyle(color: _color1, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}