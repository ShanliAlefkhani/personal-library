class Book {
  String url, title, image, description, publisher, authors, isbn;
  double rate;
  String note = "";

  Book(this.isbn, this.title, this.image, this.publisher, this.authors);
  Book.second(this.title);

  static Book makeBook(var fetchedBook) {
    String authorsName = "";
    for (int j = 0; j < fetchedBook['Authors'].length; j++) {
      authorsName += fetchedBook['Authors'][j]["Name"] + " ";
    }
    Book book = new Book(
        fetchedBook['ISBN'],
        fetchedBook['Title'],
        fetchedBook['Image'],
        fetchedBook['Publisher'],
        authorsName);
    return book;
  }
}