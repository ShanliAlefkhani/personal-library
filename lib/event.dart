import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'model/folder.dart';

abstract class TestEvent extends Equatable {
  const TestEvent();
}

class GoToFirstPage extends TestEvent {
  @override
  List<Object> get props => [];
}

class GoToFolderDetail extends TestEvent  {
  final Folder folder;
  GoToFolderDetail(this.folder);

  @override
  List<Object> get props => [folder];
}