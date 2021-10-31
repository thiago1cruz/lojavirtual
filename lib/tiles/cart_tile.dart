
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/data/cart_product.dart';
import 'package:lojavirtual/data/product_data.dart';
import 'package:lojavirtual/models/cart_model.dart';


class CartTile extends StatelessWidget {

  final CartProduct cartProduct;

  const CartTile({Key? key, required this.cartProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _buildContent(){
      CartModel.of(context).updatePrice();
          return Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                width: 120,
                child: Image.network(
                    cartProduct.productData!.images.first,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            cartProduct.productData!.title,
                          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        Text(
                         'Tamanho: ${cartProduct.size}',
                          style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 17),
                        ),
                        Text(
                          ' R\$ ${cartProduct.productData!.price.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Theme.of(context).primaryColor
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: cartProduct.quantity > 1 ? (){
                                  CartModel.of(context).decProduct(cartProduct);
                                } : null,
                                icon: const Icon(Icons.remove),
                              color: Theme.of(context).primaryColor,
                            ),
                            Text(cartProduct.quantity.toString()),
                            IconButton(
                                onPressed: (){
                                  CartModel.of(context).incProduct(cartProduct);
                                },
                                icon: const Icon(Icons.add),
                              color: Theme.of(context).primaryColor,
                            ),
                            ElevatedButton(
                                onPressed: (){
                                  CartModel.of(context).removeCartItem(cartProduct);
                                },
                                style: ElevatedButton.styleFrom(primary: Colors.transparent, elevation: 0),
                                child: Text('Remover', style: TextStyle(color: Colors.grey[500]),))
                          ],
                        )
                      ],
                    ),
                  )
              )
            ],
          );
    }


    return Card(
      margin: const EdgeInsets.symmetric(horizontal:8, vertical: 4),
      child: cartProduct.productData == null?
        FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('product').doc(cartProduct.category)
              .collection('items').doc(cartProduct.pid).get(),
          builder: (context, snapshot){
            if(snapshot.hasData) {
              cartProduct.productData = ProductData.fromDocument(snapshot.data!);
              return _buildContent();
            }else{
              return Container(
                height: 70,
                child: const CircularProgressIndicator(),
                alignment: Alignment.center,
              );
            }
          }
        ):
         _buildContent()
    );
  }
}
