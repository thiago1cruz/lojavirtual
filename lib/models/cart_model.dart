
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:lojavirtual/data/cart_product.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model{

  UserModel user;

  bool isloading = false;

  List<CartProduct> products = []; 

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  CartModel({required this.user});

  void addCartItem(CartProduct cartProduct){
    products.add(cartProduct);
    FirebaseFirestore.instance.collection('users').doc(user.firebaseUser!.uid)
      .collection('cart').add(cartProduct.toMap())
       .then((doc) {
         cartProduct.cid = doc.id;
       });
   notifyListeners();
  }


  void removeCartItem(CartProduct cartProduct){
     FirebaseFirestore.instance.collection('users').doc(user.firebaseUser!.uid)
      .collection('cart').doc(cartProduct.cid).delete();
    products.remove(cartProduct);
    notifyListeners();
  }
  

}