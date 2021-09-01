
import 'package:dar_elkahrba/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class Auth {

  final _auth = FirebaseAuth.instance;

  Future sign_up_with_email_and_password(
      String Email, String Password,context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: Email,
          password: Password
      );
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      return userCredential;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.message.toString(),
          style: TextStyle(fontFamily: 'custom_font'),
        ),
      ));
      print(e.message);
      if (e.code == 'weak-password') {
        print(e.message);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

  }


  Future<void> sign_in_with_email_and_password(
      String Email, String Password,context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: Email,
          password: Password
      );
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      return null;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.message.toString(),
          style: TextStyle(fontFamily: 'custom_font'),
        ),
      ));
      print(e.message);
      if (e.code == 'weak-password') {
        print(e.message);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }


  Future signout() async{
    try{
      return await _auth.signOut();
    }catch (e){
      print(e.toString());
    }
  }





}