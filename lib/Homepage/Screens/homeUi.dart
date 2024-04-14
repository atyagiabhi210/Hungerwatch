import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hungerwatch/Homepage/components/request_post.dart';
import 'package:hungerwatch/features/CreatePost/ui/postmodalsheet.dart';

class HomePageUi extends StatefulWidget {
  @override
  State<HomePageUi> createState() {
    return _HomePageUiState();
  }
}

class _HomePageUiState extends State<HomePageUi> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 122, 204, 242),
          elevation: 20,
          focusColor: Colors.blue,
          hoverColor: Colors.blue,
          highlightElevation: 20,
          isExtended: true,
          shape: const CircleBorder(eccentricity: BorderSide.strokeAlignCenter),
          splashColor: Colors.blue,

          onPressed: () {
            
            showModalBottomSheet(
                isScrollControlled: true,
                
                enableDrag: true,
                //barrierColor: Colors.yellowAccent,
                context: context,
                builder: (context) {
                  return PostModalSheet();
                });
          },
          child: Icon(Icons.add, color: Colors.white, size: 30),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        
        body: Center(
            child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [Center(child: Text("  Recent Posts!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),)],),
            //EXPANDED POSTS OF REQUESTS
            Expanded(
                child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("posts").snapshots(),
              builder: (context, snapshot) {

                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } 
                else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error"),
                  );
                }
                else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text("No Posts"),
                  );
                }
                else {
                  //get the post
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                    final post = snapshot.data!.docs[index];
                    return PostRequest(
                        caption: post["caption"],
                        proof: post["proof"],
                        userLocation: post["userLocation"],
                        userName: post["userName"],
                      //  onTap:showCommentDialog,
                        postId: post.id);
                  });
                }
              },
            ))
          ],
        )));
  }
 
}
