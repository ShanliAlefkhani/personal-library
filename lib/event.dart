import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'model/book.dart';
import 'model/folder.dart';

abstract class TestEvent extends Equatable {
  const TestEvent();
}

class GoToFirstPage extends TestEvent {
  @override
  List<Object> get props => [];
}

class GoToFolderDetail extends TestEvent {
  final Folder folder;

  GoToFolderDetail(this.folder);

  @override
  List<Object> get props => [folder];
}

class GoToBookDetail extends TestEvent {
  final Folder folder;
  final int index;

  GoToBookDetail(this.folder, this.index);

  @override
  List<Object> get props => [folder, index];
}

class GoToSearchPage extends TestEvent {
  final Folder folder;

  GoToSearchPage(this.folder);

  @override
  List<Object> get props => [folder];
}

class GoToResultsPage extends TestEvent {
  final Folder folder;
  final String searchName;

  GoToResultsPage(this.folder, this.searchName);

  @override
  List<Object> get props => [folder];
}
