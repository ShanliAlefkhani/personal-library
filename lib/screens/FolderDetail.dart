import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koobook_project4/event.dart';
import 'package:koobook_project4/model/book.dart';
import 'package:koobook_project4/model/folder.dart';
import '../bloc.dart';

class FolderDetail extends StatefulWidget {
  TestBloc testBloc;
  final Folder folder;

  FolderDetail(this.testBloc, this.folder);

  @override
  _FolderDetailState createState() => _FolderDetailState(folder);
}

class _FolderDetailState extends State<FolderDetail> {
  final Folder folder;

  _FolderDetailState(this.folder);

  final List<String> wallPapers = [
    "assets/2.jpg",
    "assets/3.jpg",
    "assets/4.jpg",
    "assets/5.jpg"
  ];

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
            icon: Icon(Icons.wallpaper),
            onPressed: () {
              setState(() {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0)), //this right here
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
                folder.currentWallPaper,
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
        onPressed: () {
          setState(() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20.0)), //this right here
                      child: search(context));
                });
          });
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
                    folder.currentWallPaper = wallPapers[index];
                    Navigator.pop(context);
                  });
                },
              ),
            );
          }),
    );
  }

  String searchName;
  final int _nextPageThreshold = 3;
  bool hasNextPage = true, loading = true, error = false;
  int pageNum = 1;
  List<Book> searchResults = new List();

  Widget search(BuildContext context) {
    debugPrint("injaam");
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
          itemCount: searchResults.length + (hasNextPage ? 1 : 0) + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              debugPrint("${searchResults.length} ss");
              return Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
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
                      setState(() {
                        searchName = value;
                        debugPrint(value);
                        hasNextPage = true;
                        pageNum = 1;
                        error = false;
                        loading = true;
                        searchResults.clear();
                        fetchBooks();
                      });
                    } catch (exception) {}
                  },
                ),
              );
            } else {
              if (index == searchResults.length - _nextPageThreshold) {
                fetchBooks();
              }
              if (index == searchResults.length + 1) {
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
                      child:
                          Text("Error while loading photos, tap to try agin"),
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
              final Book book = searchResults[index - 1];
              return Card(
                elevation: 5,
                color: Colors.white,
                child: ListTile(
                  title: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text("${book.title}",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.amber.shade700,
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
                  onTap: () {},
                ),
              );
            }
          }),
    );
  }

  Future<void> fetchBooks() async {
    debugPrint("injaam fetch");
    try {
      Dio dio = new Dio();
      final response =
          await dio.get("https://api.koobook.app/books/", queryParameters: {
        "search": searchName,
        "fields":
            "url,Title,ISBN,Image,Description,Publisher,Price,Edition,Hashtags,Rate,Authors",
        "page": pageNum,
      });
      List fetchedBooks = response.data['results'];
      debugPrint("${fetchedBooks.length}");
      setState(() {
        if (response.data['next'] == null) {
          hasNextPage = false;
        } else {
          pageNum++;
        }
        loading = false;
        for (int i = 0; i < fetchedBooks.length; i++) {
          String authorsName = "";
          for (int j = 0; j < fetchedBooks[i]['Authors'].length; j++) {
            authorsName += fetchedBooks[i]['Authors'][j]["Name"] + " ";
          }
          Book book = new Book(
              fetchedBooks[i]['url'],
              fetchedBooks[i]['Title'],
              fetchedBooks[i]['Image'],
              fetchedBooks[i]['Description'],
              fetchedBooks[i]['Publisher'],
              fetchedBooks[i]['Rate'],
              authorsName);
          searchResults.add(book);
        }
        debugPrint("${searchResults.length}");
        return true;
      });
    } catch (e) {
      setState(() {
        loading = false;
        error = true;
      });
    }
  }
}
