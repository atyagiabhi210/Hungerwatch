import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hungerwatch/Homepage/Screens/newHomePage.dart';
import 'package:hungerwatch/features/onboarding/ui/onboarding.dart';
import 'package:hungerwatch/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    /*  theme:ThemeData.dark(
        useMaterial3: true,

      ),*/
      debugShowCheckedModeBanner: false,
      home: checkUserLoggedIn(),
    );
  }
  checkUserLoggedIn(){
    if(FirebaseAuth.instance.currentUser != null){
      return newHomePage();
    }else{
      return OnboardingScreen();
    }
  }
}
