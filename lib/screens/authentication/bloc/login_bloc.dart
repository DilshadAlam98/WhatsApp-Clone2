import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_application/screens/authentication/models/login_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginLoadingEvent>(onLoginLoading);
    on<RegisterLoadingEvent>(onRegisterLoading);
  }

  Future<FutureOr<void>> onLoginLoading(LoginLoadingEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final email = event.email;
      final password = event.password;
      final auth = FirebaseAuth.instance;
      UserCredential? credential;
      try {
        credential = await auth.signInWithEmailAndPassword(email: email, password: password);
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
      } on FirebaseAuthException catch (e) {
        print("Error: ${e.toString()}");
        if (e.code == "invalid-credential") {
          credential = await auth.createUserWithEmailAndPassword(email: email, password: password);
        }
      }

      emit(LoginSuccess(userCredential: credential!));
    } on FirebaseAuthException catch (e) {
      debugPrint("Error: ${e.toString()}");
      emit(LoginError(message: e.message ?? ""));
    }
  }

  Future<FutureOr<void>> onRegisterLoading(RegisterLoadingEvent event, Emitter<LoginState> emit) async {
    emit(RegisterLoading());
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection("users").doc(event.loginModel.uuid).set(event.loginModel.toJson());
      emit(RegisterSuccess());
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
    } on FirebaseException catch (e) {
      emit(RegisterError(message: e.message ?? ""));
    }
  }
}
