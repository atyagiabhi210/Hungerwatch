import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hungerwatch/Homepage/models/postModel.dart';

class PostRepo{

  static Future<PostModel> getAllPost() async{
    try{
      FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = FirebaseFirestore.instance.collection('posts');
    final response= firestore.collection('posts').get();
    return response.then((value) => 
      PostModel.fromMap(value.docs[0].data() as Map<String, dynamic>)
    );
    }
    catch(e){
      log("ERROR: e.toString()");
      return PostModel(caption: "", proof: "", userLocation: "", userMail: "", userName: "");
    }
    
  }

}