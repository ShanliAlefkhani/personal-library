import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koobook_project4/event.dart';
import 'package:koobook_project4/model/book.dart';
import 'package:koobook_project4/model/folder.dart';
import '../bloc.dart';
import '../hexColor.dart';

class FolderDetail extends StatefulWidget {
  TestBloc testBloc;
  final Folder folder;

  FolderDetail(this.testBloc, this.folder);

  @override
  _FolderDetailState createState() => _FolderDetailState();
}

class _FolderDetailState extends State<FolderDetail> {
  Color _color1 = HexColor("#8a8a01");
  final List<String> wallPapers = [
    "assets/2.jpg",
    "assets/4.jpg",
    "assets/5.jpg",
    "assets/6.jpg",
    "assets/7.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color1,
        centerTitle: false,
        title: Text(widget.folder.name),
        actions: [
          IconButton(
            icon: Icon(Icons.create),
            onPressed: () {
              setState(() {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: changeName(context));
                    });
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.wallpaper),
            onPressed: () {
              setState(() {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: chooseWalpaper(context));
                    });
              });
            },
          ),
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
                widget.folder.currentWallPaper,
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
            itemCount: widget.folder.books.length,
            itemBuilder: (context, index) {
              final Book book = widget.folder.books[index];
              return Card(
                elevation: 5,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.book,
                    color: _color1,
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.remove,
                      color: _color1,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.folder.books.removeAt(index);
                      });
                    },
                  ),
                  title: Text(book.title),
                  onTap: () {
                    widget.testBloc
                        .add(GoToBookDetail(this.widget.folder, index));
                  },
                ),
              );
            }),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _color1,
        child: Icon(Icons.add),
        onPressed: () {
          widget.testBloc.add(GoToSearchPage(widget.folder));
        },
      ),
    );
  }

  Widget chooseWalpaper(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 5 / 6,
      height: size.height * 5 / 6,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: ListView.builder(
          itemCount: wallPapers.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.all(30),
              child: InkWell(
                child: Image.asset(
                  wallPapers[index],
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  setState(() {
                    widget.folder.currentWallPaper = wallPapers[index];
                    Navigator.pop(context);
                  });
                },
              ),
            );
          }),
    );
  }

  String name;

  Widget changeName(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.name,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.create,
                color: _color1,
              ),
            ),
            onSubmitted: (String value) {
              name = value;
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            width: size.width / 3.5,
            height: size.height / 20,
            child: RaisedButton(
              elevation: 5,
              color: _color1,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
              ),
              onPressed: () async {
                setState(() {
                  widget.folder.name = name;
                });
                Navigator.pop(context);
              },
              child: Text(
                'save',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
