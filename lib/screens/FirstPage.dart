import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:koobook_project4/model/folder.dart';
import '../bloc.dart';
import '../event.dart';
import '../hexColor.dart';

class FirstPage extends StatefulWidget {
  TestBloc testBloc;

  FirstPage(this.testBloc);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  Color _color1 = HexColor("#666600");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color1,
        title: Text(
          "Personal Page",
          style: TextStyle(color: Colors.white),
        ),
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
                "assets/1.jpg",
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
                  leading: Icon(
                    Icons.folder,
                    color: _color1,
                  ),
                  title: Text(folder.name),
                  onTap: () {
                    widget.testBloc.add(GoToFolderDetail(folder));
                  },
                ),
              );
            }),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _color1,
        child: Icon(Icons.create_new_folder),
        onPressed: () {
          setState(() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: addFolder(context));
                });
          });
        },
      ),
    );
  }

  String name;

  Widget addFolder(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.name,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.create,
                color: _color1,
              ),
            ),
            onSubmitted: (String value) {
              name = value;
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            width: size.width / 3.5,
            height: size.height / 20,
            child: RaisedButton(
              elevation: 5,
              color: _color1,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
              ),
              onPressed: () async {
                setState(() {
                  //inja hive
                  Hive.box('folders').add(new Folder(name));
                  Folder.list.add(new Folder(name));
                });
                Navigator.pop(context);
              },
              child: Text(
                'save',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
