import 'package:equatable/equatable.dart';
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

class Home extends TestState {
}