

import 'package:flutter/material.dart';
import 'package:lojavirtual/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';



class CartPrice extends StatelessWidget {
  final VoidCallback buy;
  const CartPrice({Key? key, required this.buy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            double price = model.getProductsPrice();
            double discount = model.getDiscountPrice();
            double ship = model.getShipPrice();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
               const  Text(
                  'Resulmo do pedido',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
               const  SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   const  Text('SubTotal'),
                    Text('R\$ ${price.toStringAsFixed(2)}'),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Desconto'),
                    Text('R\$ ${discount.toStringAsFixed(2)}'),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Entrega'),
                    Text('R\$ ${ship.toStringAsFixed(2)}'),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total',
                      style: TextStyle(fontWeight: FontWeight.w500),),
                    Text('R\$ ${((price+ship) - discount).toStringAsFixed(2)}',
                      style: TextStyle(color: Theme
                          .of(context)
                          .primaryColor, fontSize: 16),),
                  ],
                ),
                const SizedBox(height: 12,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(color: Colors.white),
                        primary: Theme
                            .of(context)
                            .primaryColor
                    ),
                    onPressed: buy,
                    child: const Text('Finalizar Pedido'))
              ],
            );
          }
          )
      ),
    );
  }
  }

