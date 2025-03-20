import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:perfume_store/models/user.dart';

class MyUserProvider extends ChangeNotifier {
  MyUser? _user;

  MyUser? get user => _user;

  final CollectionReference _ref = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<Map<String, dynamic>> setMyUser(MyUser user, String password) async {
    try {
      _auth.createUserWithEmailAndPassword(
          email: user.email, password: password);
      _ref.add(MyUser.toJson(user));
      _user = user;
      notifyListeners();
      return {'status':true, 'message':"Successfully created an account"};
    } on FirebaseException catch (e) {
      _user = null;
      notifyListeners();
            return {'status':false, 'message':e.code};

    }
  }

  Future<Map<String, dynamic>> logInMyUser(String email, String password) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
      await _ref.where('email', isEqualTo: email).get().then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          _user =
              MyUser.fromJson(querySnapshot.docs.first.data() as Map<String, dynamic>);
        }
      });
      notifyListeners();
      return {'status':true, 'message':"Successfully created an account"};
    } on FirebaseException catch (e) {
      
      _user = null;
      notifyListeners();
      return {'status':false, 'message':e.code};
    }
  }
}
