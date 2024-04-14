import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hungerwatch/Homepage/components/comments.dart';
class PostRequest extends StatefulWidget {
  final String caption;
  final String proof;
  final String userLocation;
  final String userName;
  
  final String postId;
  const PostRequest(
      {required this.caption,
      required this.proof,
      required this.userLocation,
      required this.userName,
     // required this.onTap,
      required this.postId});

  @override
  _PostRequestState createState() => _PostRequestState(
      caption: caption,
      proof: proof,
      userLocation: userLocation,
      userName: userName,
      postId: postId
  );
}

class _PostRequestState extends State<PostRequest> {
   final String caption;
   final String postId;
  final String proof;
  final String userLocation;
  final String userName;
   _PostRequestState(
      {required this.caption,
      required this.proof,
      required this.userLocation,
      required this.userName,
      required this.postId});

  TextEditingController commentController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return tweetCard(widget.caption, widget.proof, widget.userLocation, widget.userName);
  }

  Widget tweetCard(
    final String caption,
    final String proof,
    final String userLocation,
    final String userName,
  ) {
    return Card(
      color: const Color.fromARGB(255, 46, 46, 46),
      elevation: 3,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        Text(
                          userLocation,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    /* Text(
                      "@" + handle,
                      style: TextStyle(color: Colors.grey),
                    ),*/
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            // SizedBox(height: 10),
            if (proof != null) // Conditionally display image if URL is provided
              Image.network(
                proof!,
                width: double.infinity, // Image takes full width of the card
                fit: BoxFit.cover, // Image fills the container
              ),
            Text(
              caption,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    showCommentDialog(context, postId);
                  },
                  child: Icon(Icons.comment_bank_outlined),
                ),
                SizedBox(width: 10),
                Icon(Icons.delete_outline),
              ],
            ),
            
            TextButton(onPressed: (){
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
              
            }, child: Text("View Comments")),
            Divider(
              thickness: 2,
              color: Colors.grey,
            ),
            //displaying the comments
            
          ],
        ),
      ),
    );
  }
   // add a comment
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
  //show a dialog box
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
  //displaying the comments
  
}
/*class PostRequest extends StatelessWidget {

  final String caption;
  final String proof;
  final String userLocation;
  final String userName;
  final Function onTap;
  final String postId;
  const PostRequest(
      {required this.caption,
      required this.proof,
      required this.userLocation,
      required this.userName,
      required this.onTap,
      required this.postId});

      //add a comment:
      
  @override
  Widget build(BuildContext context) {
    return tweetCard(caption, proof, userLocation, userName);
  }

  Widget tweetCard(
    final String caption,
    final String proof,
    final String userLocation,
    final String userName,
  ) {
    return Card(
      color: const Color.fromARGB(255, 46, 46, 46),
      elevation: 3,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        Text(
                          userLocation,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    /* Text(
                      "@" + handle,
                      style: TextStyle(color: Colors.grey),
                    ),*/
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            // SizedBox(height: 10),
            if (proof != null) // Conditionally display image if URL is provided
              Image.network(
                proof!,
                width: double.infinity, // Image takes full width of the card
                fit: BoxFit.cover, // Image fills the container
              ),
            Text(
              caption,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(onTap: (){
                  onTap;
                },
                child:  Icon(Icons.comment_bank_outlined),),
               
                SizedBox(width: 10),
                Icon(Icons.delete_outline),
              ],
            ),
            Divider(
              thickness: 2,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
*/