// ignore_for_file: prefer_const_constructors, camel_case_types, null_argument_to_non_null_type

import 'package:flutter/material.dart';
import 'package:notes/Model.dart';
import 'package:notes/first.dart';
import 'package:sqflite/sqflite.dart';

class new_note extends StatefulWidget {
  const new_note({Key? key}) : super(key: key);

  @override
  State<new_note> createState() => _new_noteState();
}

class _new_noteState extends State<new_note> {
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();

  Database? db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Model().createDatabase().then((value) {
      db = value;
    });
  }

  Future<bool> goBack() {
    String title_note = title.text;
    String note_text = note.text;

    if (title_note.isEmpty && note_text.isEmpty) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return first();
        },
      ));
    } else {
      String qry =
          "INSERT INTO notes (title,note) values ('$title_note','$note_text')";
      db!.rawInsert(qry).then((value) {
        print(value);
      });
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return first();
        },
      ));
    }
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: goBack,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {
                        String title_note = title.text;
                        String note_text = note.text;

                        if (title_note.isEmpty && note_text.isEmpty) {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return first();
                            },
                          ));
                        } else {
                          String qry =
                              "INSERT INTO notes (title,note) values ('$title_note','$note_text')";
                          db!.rawInsert(qry).then((value) {
                            print(value);
                          });
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return first();
                            },
                          ));
                        }
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: TextFormField(
                    cursorColor: Colors.orange,
                    style: TextStyle(),
                    controller: title,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "Title",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: TextField(
                        cursorColor: Colors.orange,
                        autofocus: true,
                        controller: note,
                        scrollPadding: EdgeInsets.all(20.0),
                        keyboardType: TextInputType.multiline,
                        maxLines: 99999,
                        style:
                            TextStyle(color: Color(0xff9d9c9c), fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
