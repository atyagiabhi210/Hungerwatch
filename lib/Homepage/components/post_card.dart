// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hungerwatch/Homepage/components/comments.dart';

class PostCard extends StatelessWidget {
  final String caption;
  final String proof;
  final String userLocation;
  final String userName;
  final String postId;
   PostCard({
    Key? key,
    required this.caption,
    required this.proof,
    required this.userLocation,
    required this.userName,
    required this.postId,
  }) : super(key: key);
final commentController=TextEditingController();
void showCommentDialog(BuildContext context, String postId){
    showDialog(context: context, builder: (context){
      
      return AlertDialog(
        title: Text("Add a comment"),
        content: TextField( 
          controller:commentController,
          decoration: InputDecoration(
            hintText: "Enter your comment"
          ),
          
        ),
        actions: [ 
          TextButton(onPressed: (){
            addComment(commentController.text, postId).then((value) => {
              if(value){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Comment added")))
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to add comment")))
              }
            }) ;
            commentController.clear();
           // Navigator.pop(context);
          }, child: Text("Add Comment")),
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Cancel"))
        ],
      );
    });
  }

 Future<bool> addComment(String text, String postId)async {
    try{
      FirebaseFirestore.instance.collection("comments").add({
      "comment":text,
      "postId":postId,
      "userMail": FirebaseAuth.instance.currentUser?.email,
      "userName":"Abhishek"
    });
    return true;
    }
    catch(e){
      return false;
    }
    
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
      padding: EdgeInsets.all(5),
      width: 280,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // pic
          if (proof != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                proof!,
                //width: double.infinity, // Image takes full width of the card
                // fit: BoxFit.cover, // Image fills the container
              ),
            ),
          SizedBox(
            height: 10,
          ), // Conditionally display image if URL is provided
          Text(
            caption,
            style: TextStyle(color: Colors.grey.shade600),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Icon(Icons.location_on), Text(userLocation)],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [GestureDetector(
                  onTap: () {
                    showCommentDialog(context, postId);
                  },
                  child: Icon(Icons.comment_bank_outlined),
                ),TextButton(onPressed: (){
              showModalBottomSheet(context: context, builder: (context){
                return Container(
                  child:StreamBuilder<QuerySnapshot>(
              stream:FirebaseFirestore.instance.collection("comments").where("postId",isEqualTo:postId).snapshots() ,
              builder:(context,snapshot){
                    if(!snapshot.hasData){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    return ListView( 
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: snapshot.data!.docs.map((doc) {
                        //get the data
                        final commentData=doc.data() as Map<String,dynamic>;
                        //return the comment
                        return Comment(text: commentData["comment"], username: commentData["userName"],);
                      }).toList(),
                    );
            } ,) ,);
              });
              
            }, child: Text("Comments"))],
              ),
            ],
          )
        ],
      ),
    );
  }
}
