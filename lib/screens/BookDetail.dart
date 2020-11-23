import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koobook_project4/model/book.dart';
import 'package:koobook_project4/model/folder.dart';
import '../bloc.dart';
import '../event.dart';
import '../hexColor.dart';

class BookDetail extends StatefulWidget {
  TestBloc testBloc;
  final Folder folder;
  final int index;

  BookDetail(this.testBloc, this.folder, this.index);

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  Color _color1 = HexColor("#b5af0b");
  bool loading, error;
  Book book;

  @override
  initState() {
    super.initState();
    book = widget.folder.books[widget.index];
    if (book.isbn != null && book.description == null) {
      loading = true;
      error = false;
      fetchBook();
    } else {
      loading = false;
      error = false;
    }
  }

  Future<void> fetchBook() async {
    try {
      Dio dio = new Dio();
      final response =
          await dio.get('https://api.koobook.app/scanbook/', queryParameters: {
        "isbn": book.isbn,
      });
      setState(() {
        loading = false;
        book.description = response.data['Description'];
        book.rate = response.data['Rate'];
        return true;
      });
    } catch (e) {
      loading = false;
      error = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: _color1,
        title: Text(
          book.title,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.keyboard_return),
              onPressed: () =>
                  widget.testBloc.add(GoToFolderDetail(widget.folder))),
        ],
      ),
      body: getBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _color1,
        child: Icon(Icons.note_add),
        onPressed: () {
          setState(() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: addNote(context));
                });
          });
        },
      ),
    );
  }

  Widget getBody() {
    if (book.isbn == null) {
      return Container(
        margin: EdgeInsets.all(20),
        child: Text(
          "notes: " + book.note,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      );
    } else {
      if (loading) {
        return Center(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ));
      } else if (error) {
        return Center(
            child: InkWell(
          onTap: () {
            setState(() {
              loading = true;
              error = false;
              fetchBook();
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text("Error while loading photos, tap to try agin"),
          ),
        ));
      } else {
        return Container(
          margin: EdgeInsets.all(20),
          child: ListView(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.all(20),
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(book.image),
                    ),
                  ),
                ),
              ),
              Text(
                book.authors,
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Text(
                book.publisher,
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    book.description,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
              Text(
                "rate: ${book.rate}",
                style: TextStyle(color: _color1, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Container(
                  height: 0.5,
                  color: Colors.grey,
                ),
              ),
              Text(
                "notes: " + book.note,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        );
      }
    }
  }

  String name = "";

  Widget addNote(BuildContext context) {
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
                  book.note = name;
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
