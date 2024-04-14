import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungerwatch/Homepage/Screens/homepage.dart';
import 'package:hungerwatch/features/authentication/bloc/auth_bloc.dart';
import 'package:hungerwatch/features/authentication/ui/signin.dart';



class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = AuthBloc();
    return BlocConsumer<AuthBloc, AuthState>(
      bloc:authBloc,
      listener: (context, state) {
        // TODO: implement listener
        if(state is AuthSuccessState){
          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>HomePage()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case AuthInitialState:
            return Scaffold(
          appBar: AppBar(
            title: Text('Auth Screen'),
          ),
          body: SingleChildScrollView(
            child: Center(
                child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
               /* Image.asset('assets/logo/final_logo.png',
                    height: 100, width: 100),*/
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Sign In',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                     // focusColor: lightTheme.primaryColor,
                      hintText: 'Email',
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                  /*  print(emailController.text);
                    print(passwordController.text);
                    // Navigator.pushNamed(context, '/onboarding');*/
                    authBloc.add(AuthSignInEvent(email: emailController.text, password: passwordController.text));
                  },
                  child: Text('Sign In'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()));
                    },
                    child: Text(
                      'Don\'t have an account? Sign Up',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                )
              ],
            )),
          ),
        );
        case AuthLoadingState:
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator()
          )
        );
        case AuthErrorState:
        return Scaffold(
          body: Center(
            child: Text("Error: ${(state as AuthErrorState).message}")
          ),);
          default:
          return Scaffold(body: 
          Center(child: Text("OOPS"),),);
        }
        
      },
    );
  }
}
