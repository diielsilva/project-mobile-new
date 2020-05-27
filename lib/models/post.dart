import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';


class Post {
  String _title;
  String _breed;
  String _description;
  String _postedBy;
  String url;
  String state;
  var date;
  Post();
  Post.add(this._title, this._breed, this._description, this._postedBy);

  insertPost(String param, Post post, File img) async {
    this.date = DateTime.now();
    if (img == null) {
      this.url = '';
    } else {
      StorageUploadTask upload = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(img);
      var imgFile = await upload.onComplete;
      this.url = await imgFile.ref.getDownloadURL();
    }
    var database = Firestore.instance;
    var checkLength = await database.collection('posts').getDocuments();
    var stateUser = await database.collection('users').where('username',isEqualTo: this._postedBy).getDocuments();
    stateUser.documents.forEach((item){
      this.state = item.data['state'];
    });


    await database.collection('posts').add({
      'title': post._title,
      'breed': post._breed,
      'description': post._description,
      'postedBy': post._postedBy,
      'urlImage': this.url,
      'date': this.date,
      'state': this.state
    });
    var result = await database.collection('posts').getDocuments();
    print(this.url);
    if (result.documents.length > checkLength.documents.length) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  deletePost(String idpost, String image) async{
    var database = Firestore.instance;
    await database.collection('posts').document('${idpost}').delete();
    StorageReference photo = await FirebaseStorage.instance.getReferenceFromUrl('${image}');
    photo.delete();

  }

  editPost(String idpost, var image, var newImage, var title, var breed, var description) async{
    print(image);
    var database = Firestore.instance;
    if(image != "nulo" && newImage != null){
      StorageReference photo = await FirebaseStorage.instance.getReferenceFromUrl('${image}');
      photo.delete();

      StorageUploadTask upload = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(newImage);

      var fileImage = await upload.onComplete;
      var newUrl = await fileImage.ref.getDownloadURL();

      database.collection('posts').document('${idpost}').updateData({
        'title': title,
        'breed': breed,
        'description': description,
        'urlImage': newUrl
      });
    }
    else if(image == "nulo" && newImage != null){
      StorageUploadTask upload = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(newImage);

      var fileImage = await upload.onComplete;
      var newUrl = await fileImage.ref.getDownloadURL();

      database.collection('posts').document('${idpost}').updateData({
        'title': title,
        'breed': breed,
        'description': description,
        'urlImage': newUrl
      });
    }
    else{
      database.collection('posts').document('${idpost}').updateData({
        'title': title,
        'breed': breed,
        'description': description
      });
    }

  }

}
