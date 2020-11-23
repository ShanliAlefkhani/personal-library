import 'package:hive/hive.dart';
import 'book.dart';

part 'folder.g.dart';

@HiveType()
class Folder {
  static List<Folder> list = new List();
  @HiveField(0)
  String name;
  //inja bayad az ro list bekhune
  @HiveField(1)
  String currentWallPaper = "assets/2.jpg";
  //in bayad be hive ezafe she
  List<Book> books = new List();

  Folder(this.name);

  void addBook(Book book) {
    this.books.add(book);
  }
}