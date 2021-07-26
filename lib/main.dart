import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_8/add.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.black),
      home: CloudFirestoreDemo(),
    );
  }
}

class CloudFirestoreDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Notes',
          style: TextStyle(letterSpacing: 1.0, color: Colors.redAccent),
        ),
      ),
      body: StreamBuilder(
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data!.docs[index];
                return ListTile(
                  title: Text(
                    ds['title'],
                    style: TextStyle(
                        color: Colors.white, fontSize: 16, letterSpacing: 1.0),
                  ),
                  subtitle: Text(
                    ds['desc'],
                    style: TextStyle(color: Colors.white54),
                  ),
                  trailing: InkWell(
                      splashColor: Colors.redAccent,
                      onTap: () {
                        try {
                          FirebaseFirestore.instance
                              .collection('todo')
                              .doc(ds.id)
                              .delete();
                        } on Exception catch (e) {
                          print(e);
                        }
                      },
                      child: Icon(Icons.minimize, color: Colors.red)),
                );
              },
            );
          },
          stream: FirebaseFirestore.instance.collection('todo').snapshots()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddItem()));
        },
      ),
    );
  }
}
