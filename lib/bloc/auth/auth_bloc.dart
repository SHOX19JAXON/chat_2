import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthLoginEvent>(_login);
    on<AuthRegisterEvent>(_register);
    on<AuthInitialEvent>(_initialState);
  }

  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> _login(AuthLoginEvent event, emit) async {
    emit(AuthLoadingState());
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      _fireStore.collection('users').doc(userCredential.user!.uid).set(
        {
          'uuid': userCredential.user!.uid,
          'email': event.email,
        },
        SetOptions(
          merge: true,
        ),
      );
      emit(AuthSuccessState());
    } catch (error) {
      emit(AuthErrorState(errorText: error.toString()));
    }
  }

  Future<void> _register(AuthRegisterEvent event, emit) async {
    emit(AuthLoadingState());
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      await FirebaseAuth.instance.currentUser!.updateDisplayName(event.name);
      _fireStore.collection('users').doc(userCredential.user!.uid).set(
        {
          'uuid': userCredential.user!.uid,
          'email': event.email,
          'name': event.name,
        },
      );
      emit(AuthSuccessState());
    } catch (error) {
      emit(AuthErrorState(errorText: error.toString()));
    }
  }

  _initialState(AuthInitialEvent event, emit) {
    emit(AuthInitialState());
  }
}
