import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:koobook_project4/screens/BlocHandler.dart';
import 'BlockDelegate.dart';
import 'bloc.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/subjects.dart';

void main() async {
  BlocSupervisor.delegate = AppBlocDelegate();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<TestBloc>(
        create: (context) => TestBloc(),
      ),
    ],
    child: MaterialApp(home: TestingPage()),
  ));
}
