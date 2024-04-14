import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungerwatch/Homepage/Screens/homepage.dart';
import 'package:hungerwatch/features/authentication/bloc/auth_bloc.dart';

class SignInScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignInScreenState();
  
  }

}

class _SignInScreenState extends State<SignInScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthBloc authBloc = AuthBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          // TODO: implement listener
          if(state is UserCreatedSuccessState){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case AuthInitialState:
              return Scaffold(
                body: SingleChildScrollView(
                  child: Center(
                      child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                 /*     Image.asset('assets/logo/final_logo.png',
                          height: 100, width: 100),*/
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                            hintText: 'First Name',
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
                          controller: lastNameController,
                          decoration: InputDecoration(
                            hintText: 'Last Name',
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
                          controller: emailController,
                          decoration: InputDecoration(
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
                          authBloc.add(AuthSignUpEvent(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              email: emailController.text,
                              password: passwordController.text));
                          /*auth
                              .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then((value) =>
                                  print('User created: ${value.user!.email}'))
                              .catchError((error) =>
                                  print('Failed to create user: $error'));*/
                        },
                        child: Text('Sign In'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Already have an account? Sign In',
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
                  child: CircularProgressIndicator(),
                ),
              );
            case AuthErrorState:
              return Scaffold(
                body: Center(
                  child: Text('Error: ${(state as AuthErrorState).message}'),
                ),
              );
            case UserCreatedSuccessState:
              return Scaffold(
                body: Center(
                  child: Text('User created successfully'),
                ),
              );
            default:
              return Scaffold(body: Center(child: Text('OOPS')));
          }
        });
  }
}