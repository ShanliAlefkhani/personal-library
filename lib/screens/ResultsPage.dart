import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koobook_project4/event.dart';
import 'package:koobook_project4/model/book.dart';
import 'package:koobook_project4/model/folder.dart';
import '../bloc.dart';
import '../hexColor.dart';

class ResultsPage extends StatefulWidget {
  TestBloc testBloc;
  final Folder folder;
  final String searchName;

  ResultsPage(this.testBloc, this.folder, this.searchName);

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  Color _color1 = HexColor("#de1b1b");
  final int _nextPageThreshold = 3;
  bool hasNextPage, loading, error;
  int pageNum;
  List<Book> bookList = new List();

  @override
  void initState() {
    super.initState();
    hasNextPage = true;
    pageNum = 1;
    error = false;
    loading = true;
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      Dio dio = new Dio();
      final response =
          await dio.get("https://api.koobook.app/books/", queryParameters: {
        "search": widget.searchName,
        "fields":
            "url,Title,ISBN,Image,Description,Publisher,Price,Edition,Hashtags,Rate,Authors",
        "page": pageNum,
      });
      List fetchedBooks = response.data['results'];
      setState(() {
        if (response.data['next'] == null) {
          hasNextPage = false;
        } else {
          pageNum++;
        }
        for (int i = 0; i < fetchedBooks.length; i++) {
          bookList.add(Book.makeBook(fetchedBooks[i]));
        }
        loading = false;
        return true;
      });
    } catch (e) {
      setState(() {
        loading = false;
        error = true;
      });
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
            widget.searchName,
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.keyboard_return),
                onPressed: () =>
                    widget.testBloc.add(GoToFolderDetail(widget.folder))),
          ],
        ),
        body: getBody());
  }

  Widget getBody() {
    if (bookList.isEmpty) {
      if (loading) {
        return Center(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ));
      } else if (error) {
        return Center(
            child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text("Error while loading photos, tap to try agin"),
          ),
          onTap: () {
            setState(() {
              loading = true;
              error = false;
              fetchBooks();
            });
          },
        ));
      } else {
        return ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return newBookCard(context);
            });
      }
    } else {
      return ListView.builder(
          itemCount: bookList.length + (hasNextPage ? 1 : 0) + 1,
          itemBuilder: (context, index) {
            if (index == bookList.length - _nextPageThreshold) {
              fetchBooks();
            }
            if (index == 0) {
              return newBookCard(context);
            } else {
              if (index == bookList.length) {
                if (error) {
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
                      child: Text("Error while loading books, tap to try agin"),
                    ),
                  ));
                } else {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  ));
                }
              }
              final Book book = bookList[index - 1];
              return Card(
                elevation: 5,
                color: Colors.white,
                child: ListTile(
                  title: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text("${book.title}",
                        style: TextStyle(
                          fontSize: 20,
                          color: _color1,
                        )),
                  ),
                  subtitle: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.authors,
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          Text(
                            "${book.publisher}",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ]),
                  ),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.blueGrey.shade900,
                    backgroundImage: NetworkImage(
                      book.image,
                    ),
                  ),
                  onTap: () {
                    widget.folder.addBook(book);
                    widget.testBloc.add(GoToFolderDetail(widget.folder));
                  },
                ),
              );
            }
          });
    }
    return Container();
  }

  String name = "";

  Widget addBook(BuildContext context) {
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
                  widget.folder.addBook(new Book.second(name));
                });
                Navigator.pop(context);
                widget.testBloc.add(GoToFolderDetail(widget.folder));
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

  Widget newBookCard(BuildContext context) {
    return Card(
        elevation: 5,
        color: Colors.white,
        child: ListTile(
          leading: Icon(
            Icons.add_box,
            color: _color1,
          ),
          onTap: () {
            //widget.folder.addBook(book);
            setState(() {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(20.0)),
                        child: addBook(context));
                  });
            });
          },
          title: Directionality(
            textDirection: TextDirection.ltr,
            child: Text("add a new book",
                style: TextStyle(
                  fontSize: 20,
                  color: _color1,
                )),
          ),
        ));
  }
}
