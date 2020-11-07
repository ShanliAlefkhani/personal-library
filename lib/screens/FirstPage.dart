import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koobook_project4/model/folder.dart';
import '../bloc.dart';
import '../event.dart';

class FirstPage extends StatefulWidget {
  TestBloc  testBloc;
  FirstPage(this.testBloc);
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
    Folder.list.add(new Folder("first folder"));
    Folder.list.add(new Folder("second folder"));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Personal Page"),
      ),
      backgroundColor: Colors.grey,
      body: Stack(children: [
        Container(
          width: size.width,
          height: size.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/download.jpg",
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.hue,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0x6a6a6a).withOpacity(0.1),
                  ),
                ),
              )
            ],
          ),
        ),
        ListView.builder(
            itemCount: Folder.list.length,
            itemBuilder: (context, index) {
              final Folder folder = Folder.list[index];
              return Card(
                elevation: 5,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.folder),
                  title: Text(folder.name),
                  onTap: () {
                    widget.testBloc.add(GoToFolderDetail(folder));
                    /*Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => FolderDetail(folder)),
                    );*/
                  },
                ),
              );
            }),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: Icon(Icons.create_new_folder),
        onPressed: () {
          Folder.list.add(new Folder("folder x"));
          debugPrint("injaam");
        },
      ),
    );
  }
}