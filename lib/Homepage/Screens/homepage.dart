import 'package:flutter/material.dart';
import 'package:hungerwatch/Homepage/Screens/homeUi.dart';
import 'package:hungerwatch/features/Chatbot/ui/screens/chat_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>{
  List<BottomNavigationBarItem> bottomNavScreen=[
    BottomNavigationBarItem(icon: Icon(Icons.chat_bubble,/*color: Colors.white,*/), label: "Chat Bot",),
    BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.white,), label: "Home",),
   // BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), label: "Community",),
   // BottomNavigationBarItem(icon: Icon(Icons.lock_clock,color: Colors.white,), label: "Profile",),
  ];
  int index = 1;
  void _onItemTapped(int index) {
    setState(() {
      
      this.index = index;
    });
  }

  final List<Widget> pages=[
    //ChatbotPage(),
    ChatbotPage(),
    //Center(child: Text("ChatBot"),),
    HomePageUi(),
    //ChatScreen(),
    
   // Center(child: Text("Community"),),
   // Center(child: Text("Reminder"),),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // title: Text("Hunger Watch"),
     // leading:Icon(Icons.person,), 
      

        actions: [

        
       //
       
        Image.asset('assets/app_logo.png',),
        SizedBox(width: 169,)
      ],),
      bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: index,
            onTap: (index) {
              _onItemTapped(index);
            },
            items: bottomNavScreen
          ),
      body: pages[index],
      );
    
  }
}