

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/screens/cart_screen.dart';

class CartButton extends StatelessWidget {
  const CartButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=> const CartScreen())
        );
      },
      child: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
      backgroundColor: Theme.of(context).primaryColor,
      );
  }
}