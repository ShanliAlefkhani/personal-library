import 'package:equatable/equatable.dart';
import 'model/book.dart';
import 'model/folder.dart';

abstract class TestState extends Equatable {
  const TestState();

  @override
  List<Object> get props => [];
}

class FolderDetailInit extends TestState {
  final Folder folder;

  FolderDetailInit(this.folder);
}

class BookDetailInit extends TestState {
  final Folder folder;
  final int index;

  BookDetailInit(this.folder, this.index);
}

class SearchPageInit extends TestState {
  final Folder folder;

  SearchPageInit(this.folder);
}

class ResultsPageInit extends TestState {
  final Folder folder;
  final String searchName;

  ResultsPageInit(this.folder, this.searchName);
}

class Home extends TestState {}
