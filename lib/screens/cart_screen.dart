import 'package:flutter/material.dart';
import 'package:lojavirtual/models/cart_model.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/order_screen.dart';
import 'package:lojavirtual/tiles/cart_tile.dart';
import 'package:lojavirtual/widgets/cart_price.dart';
import 'package:lojavirtual/widgets/discount_card.dart';
import 'package:lojavirtual/widgets/ship_card.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Carrinho'),
        actions: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 8),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) => Text(model.products.length.toString()+(model.products.length <= 1 ?' Item':' Items'),
                style: const TextStyle(fontSize: 17),
              ),
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isloading && UserModel.of(context).isLoggedIn()) {
            return const Center(child: CircularProgressIndicator());
          } else if (!UserModel.of(context).isLoggedIn()) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.remove_shopping_cart_outlined,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Faça o login para adicionar produtos!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(  height: 16, ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>const LoginScreen())
                        );
                      },
                      child: const Text(
                          'Entrar',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                         )
                      ))
                ],
              ),
            );
          }else if(model.products == null || model.products.length == 0) {
                return const Center(
                  child: Text('Nenhum produto no carrinho',
                  textAlign: TextAlign.center,
                  style: TextStyle( fontSize:20, fontWeight: FontWeight.bold,)
                  )
                );
          }else{
            return ListView(
              children: [
                Column(
                  children: model.products.map((e) => CartTile(cartProduct: e,)).toList(),
                ),
                const DiscountCard(),
                const ShipCard(),
                CartPrice(buy:() async {
                 String? orderId = await model.finishOrder();
                 if(orderId != null){
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => OrderScreen(orderId: orderId))
                      );
                 }
                }),
              ],
            );
          }
        },
      ),
    );
  }
}
