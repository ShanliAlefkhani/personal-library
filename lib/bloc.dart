import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koobook_project4/state.dart';
import 'event.dart';
import 'model/folder.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  @override
  TestState get initialState => Home();

  @override
  Stream<TestState> mapEventToState(TestEvent event) async* {
    if (event is GoToFolderDetail) {
      //inja
      Folder folder = new Folder("heh");
      yield FolderDetailInit(folder);
    }
    else {
      yield Home();
    }
  }
}