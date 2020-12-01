class Book {
  String url, title, image, description, publisher, authors, isbn;
  double rate;
  String note = "";
  bool hasAlarm = false;
  int alarmHour, alarmMin;

  Book(this.isbn, this.title, this.image, this.publisher, this.authors);
  Book.second(this.title);

  String getAlarmColor() {
    if (hasAlarm) {
      return "#008000";
    }
    return "#FF0000";
  }

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