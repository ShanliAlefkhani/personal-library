import 'book.dart';

class Folder {
  static List<Folder> list = new List();
  String name;
  List<Book> books = new List();

  Folder(this.name);

  void addBook(Book book) {
    this.books.add(book);
  }
}