
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:lojavirtual/data/cart_product.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model{

  UserModel user;

  bool isloading = false;

  String? couponCode;
  int discountPercentage = 0;

  List<CartProduct> products = []; 

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  CartModel({required this.user}){
    if(user.isLoggedIn()){
        _loadCartItems();
    }
  }

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

  void incProduct(CartProduct cartProduct){
    cartProduct.quantity ++;
    FirebaseFirestore.instance.collection('users').doc(user.firebaseUser!.uid)
      .collection('cart').doc(cartProduct.cid).update(cartProduct.toMap());
    notifyListeners();
  }

  void decProduct(CartProduct cartProduct){
    cartProduct.quantity --;
    FirebaseFirestore.instance.collection('users').doc(user.firebaseUser!.uid)
        .collection('cart').doc(cartProduct.cid).update(cartProduct.toMap());
    notifyListeners();
  }

  void setCoupon(String? couponCode, int discountPercentage){
        this.couponCode = couponCode;
        this.discountPercentage = discountPercentage;
  }

  double getProductsPrice(){
    double price = 0.0;
    for(CartProduct c in products){
      if(c.productData != null){
        price += c.quantity * c.productData!.price;
      }
    }
    return price;
  }

  double getDiscountPrice(){
      return getProductsPrice() * discountPercentage / 100;
  }

  double getShipPrice(){
      return 9.99;
  }

  void updatePrice(){
    notifyListeners();
  }

  Future<String?> finishOrder() async {
    if (products.isEmpty) return null;
    isloading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscountPrice();

    DocumentReference reference = await FirebaseFirestore.instance.collection(
        'orders').add({
      'clientId': user.firebaseUser!.uid,
      'products': products.map((e) => e.toMap()).toList(),
      'shipPrice': shipPrice,
      'productsPrice': productsPrice,
      'discount': discount,
      'totalPrice': productsPrice - discount + shipPrice,
      'status': 1
    });

    await FirebaseFirestore.instance.collection('users').doc(
        user.firebaseUser!.uid)
        .collection('orders').doc(reference.id).set({'orderId': reference.id});

    final query = await FirebaseFirestore.instance.collection('users').doc(user.firebaseUser!.uid)
          .collection('cart').get();

        for(DocumentSnapshot doc in query.docs){
          doc.reference.delete();
        }

        products.clear();
        discountPercentage =0;
        couponCode = null;
        isloading = false;
        notifyListeners();

        return reference.id;
  }

  
  

  void _loadCartItems() async{
    QuerySnapshot query =    await FirebaseFirestore.instance.collection('users').doc(user.firebaseUser!.uid)
        .collection('cart').get();

    products = query.docs.map((e) => CartProduct.fromDocument(e)).toList();
    notifyListeners();
  }
  

}