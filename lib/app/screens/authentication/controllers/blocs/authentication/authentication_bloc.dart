import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationLogInEvent>(_logIn);
    on<AuthenticationLogOutEvent>(_logOut);
  }

  void _logIn(
      AuthenticationLogInEvent event, Emitter<AuthenticationState> emit) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
    List<Map<String, dynamic>> users = [];
    User? user;
    try {
      emit(AuthenticationLoadingState());
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      user = auth.currentUser;
      db.collection('users').doc(user!.uid).set({
        'uid': user.uid,
        'displayName': user.displayName,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
        'photoURL': user.photoURL,
      });
      emit(
        AuthenticationLoginState(
          user: user,
        ),
      );
    } catch (e) {
      log("ERROR: $e");
      emit(AuthenticationErrorState(errorMsg: e.toString()));
    }
  }

  void _logOut(AuthenticationLogOutEvent event,
      Emitter<AuthenticationState> emit) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      emit(AuthenticationLoadingState());
      await auth.signOut();
      emit(AuthenticationLogOutState());
    } catch (e) {
      emit(AuthenticationErrorState(errorMsg: e.toString()));
    }
  }
}
