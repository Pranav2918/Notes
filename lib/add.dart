import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  void clearText() {
    titleController.clear();

    descController.clear();
  }

  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: Text(
        'Add Note',
        style: TextStyle(color: Colors.redAccent, letterSpacing: 1.0),
      )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 110, left: 25, right: 25),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.shade200,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 3.0,
                      spreadRadius: 1.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.black,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                  border: Border.all(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new TextField(
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.red,
                          controller: titleController,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Title',
                              hintStyle: TextStyle(
                                  color: Colors.white, letterSpacing: 1.0)),
                        ),
                        new TextField(
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.red,
                          controller: descController,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Descrition',
                              hintStyle: TextStyle(
                                  color: Colors.white, letterSpacing: 1.0)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                FirebaseFirestore.instance.collection('todo').add({
                  'title': titleController.text,
                  'desc': descController.text
                });
                clearText();
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: 110,
                margin: EdgeInsets.only(top: 35),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.redAccent),
                child: Center(
                    child: Text('Add'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.white, letterSpacing: 1.0))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
