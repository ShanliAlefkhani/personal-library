import 'book.dart';

class Folder {
  static List<Folder> list = new List();
  String name;
  //inja bayad az ro list bekhune
  String currentWallPaper = "assets/2.jpg";
  List<Book> books = new List();

  Folder(this.name);

  void addBook(Book book) {
    this.books.add(book);
  }
}