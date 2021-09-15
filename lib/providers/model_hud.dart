
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ModelHud extends ChangeNotifier{
  bool isLoading = false;
  late FirebaseAuth user;
   isProgressLoading(bool isLoadingA){
     isLoading = isLoadingA;
     notifyListeners();
   }
}