

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model{

  final  _auth = FirebaseAuth.instance;
  User? firebaseUser;
  Map<String, dynamic> userData = {};

  bool isLoading = false;

  static UserModel of(BuildContext context) =>
  ScopedModel.of<UserModel>(context);

  @override
  void addListener(VoidCallback listener) {  
    super.addListener(listener);
    _loadCurrentUser();
  }
  
  void singUp({required Map<String, dynamic> userData,
  required String pass,
  required VoidCallback onSucsess,
  required VoidCallback onFail}){
    isLoading = true;
    notifyListeners();
    _auth.createUserWithEmailAndPassword(
      email: userData['email'], 
      password: pass
      ).then((user) async {
          firebaseUser = user.user;
          await _saveUserData(userData);
          onSucsess();
          isLoading = false;
          notifyListeners();
      }  ).catchError((error){
        onFail();
        isLoading = false;
        notifyListeners();
      });
  }


 void singIn({required String email, 
      required String pass, 
      required VoidCallback onSuccess, 
      required VoidCallback onFail}) async{
    isLoading = true;
    notifyListeners();
   await _auth.signInWithEmailAndPassword(email: email, password: pass).then((user) async{
         firebaseUser = user.user;
         await _loadCurrentUser();         
          onSuccess();
          isLoading = false;
          notifyListeners();
    }).catchError((error){
      onFail();
      isLoading = false;
       notifyListeners();
    });
  }

  void signOut()async{
   await _auth.signOut();
   userData = {};
   firebaseUser = null;
   notifyListeners();
  }

  Future _loadCurrentUser() async{
    if(!isLoggedIn()){
      firebaseUser = _auth.currentUser!;      
    }
    if (firebaseUser != null) {
      if (userData['name'] == null) {
        DocumentSnapshot docUser = 
        await FirebaseFirestore.instance.collection('users').doc(firebaseUser!.uid).get();  
        userData = docUser.data() as Map<String, dynamic>;       
      }
    }
    notifyListeners();
  }


  void recoverPass({required String email}){
      _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn(){
      return firebaseUser != null;
  }

  Future _saveUserData(Map<String, dynamic> userData) async{
     this.userData = userData;
      await FirebaseFirestore.instance.collection('users').doc(firebaseUser!.uid).set(userData);
  }


}