import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koobook_project4/model/folder.dart';
import 'package:koobook_project4/screens/BlocHandler.dart';
import 'BlockDelegate.dart';
import 'bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  //Hive.registerAdapter(FolderAdapter());
  BlocSupervisor.delegate = AppBlocDelegate();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<TestBloc>(
        create: (context) => TestBloc(),
      ),
    ],//فیلترشکن می خواد
    //ye lahze man ba net gushi vasl sham

    child: MaterialApp(home: TestingPage()),
  ));
}
