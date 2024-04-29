import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text("Hunger Watch"),
          backgroundColor: Colors.transparent,
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
        ),
        drawer: Drawer(
          backgroundColor: Colors.grey[800],
          child: Column(
            children: [
           const   SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/app_logo.png',
                height: 100,
              ),
            const  SizedBox(
                height: 20,
              ),
            const  Divider(
                color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Text(
                    "Profile",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  leading: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Text(
                    "Home",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  leading: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Text(
                    "About",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  leading: Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Text(
                    "Log Out",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  
                ),
              )
              // TextButton(onPressed: (){}, child: Text("Log Out",style: TextStyle(color: Colors.white,fontSize: 20),)),
            ],
          ),
        ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "  Recent Posts!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              ],
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
