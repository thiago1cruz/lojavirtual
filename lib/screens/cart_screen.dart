

import 'package:flutter/material.dart';
import 'package:lojavirtual/models/cart_model.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({ Key? key }) : super(key: key);

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
              builder: (context, child, model)=> 
              Text('${model.products.length ?? 0} ${model.products.length == 1 ?'Iten': 'Itens'}',
              style: const TextStyle(fontSize: 17),
              ),
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isloading && UserModel.of(context).isLoggedIn()) {
            return const Center(
              child: CircularProgressIndicator()
            );
          }else if(!UserModel.of(context).isLoggedIn()){
              return Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.remove_shopping_cart_outlined, 
                      size: 80,
                      color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 16,),
                      const Text(
                        'Faça o login para adicionar produtos!',
                        style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                       const SizedBox(height: 16,),
                       ElevatedButton(
                         onPressed: (){}, 
                         child: Text('Entrar ')
                         )

                  ],
                ),
              );
          }
        },
      ),
    );
  }
}