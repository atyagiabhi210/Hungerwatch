import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class MyBottomNavBar extends StatelessWidget{
  void Function(int)? onTabChange;
  MyBottomNavBar({super.key,required this.onTabChange});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container( 
      child: GNav(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        tabBackgroundColor: Colors.grey.shade100,
        tabActiveBorder: Border.all(color: Color.fromARGB(255, 233, 233, 233),),
        color: Colors.grey[400],
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 15,
        onTabChange: (value)=>onTabChange!(value),
        tabs: [ 
          GButton(icon: Icons.home,text: 'Home',),
          GButton(icon: Icons.chat_bubble,text: 'Chat Bot',),
          GButton(icon: Icons.person,text: 'Profile',),
        ],
       )
    );
  }
}