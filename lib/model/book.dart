class Book {
  static List<Book> list = new List();

  String url, title, image, description, publisher, authors;
  double rate;

  Book(this.url, this.title, this.image, this.description, this.publisher, this.rate, this.authors);
  Book.first(this.title);

  static void makeList(List fetchedBooks) {
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
      Book.list.add(book);
    }
  }
}