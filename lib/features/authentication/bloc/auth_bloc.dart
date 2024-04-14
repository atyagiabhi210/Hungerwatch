import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthSignUpEvent>(authSignUpEvent);
    on<AuthSignInEvent>(authSignInEvent);
    on<AuthEvent>((event, emit) {});
  }
  FutureOr authSignUpEvent(
      AuthSignUpEvent event, Emitter<AuthState> emit) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    print('AuthSignUpEvent Invoked');

    emit(AuthLoadingState());

    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      print('User created: ${user.user!.email}');
      Dio dio = Dio();
      /*final String base_url = constants.Base_URL;
      try {
        final userCreated = await dio.post("https://flutter-fs-backend.onrender.com/api/v1/user", data: {
        "uid": auth.currentUser!.uid,
        "tweets": [],
        "firstName": event.firstName,
        "lastName": event.lastName,
        "email": event.email,
        "createdAt": DateTime.now().toString()
      });
      
      print(userCreated.data.toString());
      } catch (e) {
       
        print("error ${e.toString()}");
        emit(AuthErrorState(message: e.toString()));
      }
      */
      emit(UserCreatedSuccessState());
    } catch (e) {
      emit(AuthErrorState(message: e.toString()));
    }
  }

  FutureOr authSignInEvent(
      AuthSignInEvent event, Emitter<AuthState> emit) async {
    print("Sign In Invoked");
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: event.email, password: event.password);

      print('User signed in: ${user.user!.email}');
    } catch (e) {
      emit(AuthErrorState(message: e.toString()));
    }
  }
}
