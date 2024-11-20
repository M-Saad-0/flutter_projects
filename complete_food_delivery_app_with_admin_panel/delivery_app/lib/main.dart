import 'package:bloc/bloc.dart';
import 'package:delivery_app/app.dart';
import 'package:delivery_app/firebase_options.dart';
import 'package:delivery_app/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:user_repository/user_repository.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(userRepository:  FirebaseUserRepository()));
}

