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
    if (book.description == null) {
      loading = true;
      error = false;
      fetchBooks();
    }
    else {
      loading = false;
      error = false;
    }
  }

  Future<void> fetchBooks() async {
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
    );
  }

  Widget getBody() {
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
            fetchBooks();
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text("Error while loading photos, tap to try agin"),
        ),
      ));
    } else {
      return ListView(
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
        ],
      );
    }
  }
}
