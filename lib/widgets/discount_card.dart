

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/cart_model.dart';


class DiscountCard extends StatelessWidget {
  const DiscountCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        leading: const Icon(Icons.card_giftcard),
        trailing: const Icon(Icons.add),
        title: Text(
          'Cupon de Desconto',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700]
          ),
        ),
        children: [
          Padding(
              padding: const EdgeInsets.all(8),
            child: TextField(
              restorationId: CartModel.of(context).couponCode ??'',
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite seu cupom'
              ),
              onSubmitted: (text){
                  FirebaseFirestore.instance.collection('coupons').doc(text).get()
                      .then((doc)  {
                        if(doc.data() != null ){
                          CartModel.of(context).setCoupon(text, doc.get('percent'));
                          ScaffoldMessenger.of(context)
                              .showSnackBar( SnackBar(
                            content: Text('DEsconto de ${doc.get('percent')}% aplicado!',),
                            backgroundColor: Theme.of(context).primaryColor,
                          ));
                        }else{
                          CartModel.of(context).setCoupon(null, 0);
                          ScaffoldMessenger.of(context)
                              .showSnackBar( const SnackBar(
                            content:  Text('Cupom não existente!',),
                            backgroundColor: Colors.redAccent,
                          ));
                        }
                  });
              },
            ),
          )
        ],
      ),
    );
  }
}
