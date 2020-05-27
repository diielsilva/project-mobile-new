import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:prototype/details_my_posts.dart';

class MyPosts extends StatefulWidget {
  String user;

  MyPosts(param) {
    this.user = param;
  }

  @override
  _MyPostsState createState() => _MyPostsState(this.user);
}

class _MyPostsState extends State<MyPosts> {
  _MyPostsState(param) {
    this.user = param;
    this.operationList = Firestore.instance
        .collection('posts')
        .where('postedBy', isEqualTo: this.user)
        .orderBy('date', descending: true)
        .snapshots();
  }

  String user;
  var operationList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Publicações"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                this.operationList = Firestore.instance
                    .collection('posts')
                    .where('postedBy', isEqualTo: this.user)
                    .orderBy('date', descending: true)
                    .snapshots();
              });
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: this.operationList,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    List<DocumentSnapshot> documents = snapshot.data.documents;

                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(documents[index].data['title']),
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(documents[index].data['urlImage']),
                          ),
                          subtitle: Text(documents[index].data['description']),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DetailsMyPost(
                                  documents[index].data['title'],
                                  documents[index].data['breed'],
                                  documents[index].data['urlImage'],
                                  documents[index].data['description'],
                                  documents[index].documentID);
                            }));
                          },
                        );
                      },
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
