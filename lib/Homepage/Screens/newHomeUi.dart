import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hungerwatch/Homepage/components/post_card.dart';

class NewHomeUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewHomeUIState();
  }
}

class _NewHomeUIState extends State<NewHomeUI> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Recent Posts in your area',
            style: TextStyle(color: Colors.grey.shade800, fontSize: 18),
          ),
        ),
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
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error"),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text("No Posts"),
                  );
                } else {
                  //get the post
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final post = snapshot.data!.docs[index];
                        return PostCard(
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
    );
  }
}
