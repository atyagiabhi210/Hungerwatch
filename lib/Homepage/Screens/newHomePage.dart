import 'package:flutter/material.dart';
import 'package:hungerwatch/Homepage/Screens/newHomeUi.dart';
import 'package:hungerwatch/Homepage/components/bottom_nav_bar.dart';
import 'package:hungerwatch/features/Chatbot/ui/screens/chat_page.dart';

class newHomePage extends StatefulWidget{
  State<newHomePage> createState() {
    return _newHomePageState();
  }

}

class _newHomePageState extends State<newHomePage>{
  int _selectedIndex = 0;
  navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
   final List<Widget> pages=[
    //ChatbotPage(),
    NewHomeUI(),
   // HomePageUi(),
    ChatbotPage(),
    //Center(child: Text("ChatBot"),),
   Center(child: Text('Profile'))
    
    //ChatScreen(),
    
   // Center(child: Text("Community"),),
   // Center(child: Text("Reminder"),),
  ];
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
      //backgroundColor: Colors.grey[300],
      bottomNavigationBar: MyBottomNavBar( 
        onTabChange: (index)=>navigateBottomBar(index),
      ),
      body: pages[_selectedIndex],
    );
  }
  
  
}