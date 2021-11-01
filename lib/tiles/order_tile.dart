

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {

  final String orderId;

  const OrderTile({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('orders').doc(orderId).snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }else{
              int status = snapshot.data!.get('status');
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Código do Pedido: ${snapshot.data!.id}',
                   style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4,),
                  Text(
                    _buildProductText(snapshot.data!)
                  ),
                  const SizedBox(height: 4,),
                  const Text('Status do Pedido:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       _buildCircle(title: '1', subtitle: 'Preparação', status: status, thisStstus: 1),
                       Container(height: 1,width: 40,color: Colors.grey[500],),
                       _buildCircle(title: '2', subtitle: 'Transporte', status: status, thisStstus: 2),
                         Container(height: 1,width: 40,color: Colors.grey[500],),
                       _buildCircle(title: '3', subtitle: 'Entrega', status: status, thisStstus: 3),
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String _buildProductText(DocumentSnapshot data){
    String text = 'Descrição:\n';

    for(LinkedHashMap p in data.get('products')){
      text += '${p['quantity']} x ${p['product']['title']} (R\$ ${p['product']['price'].toStringAsFixed(2)})\n';
    }
    text += 'Total: R\$ ${data.get('totalPrice').toStringAsFixed(2)}';
    return text;
  }

  Widget _buildCircle(
      {required String title, required String subtitle, required int status, required int thisStstus})  {
      Color backColor;
      Widget child;

      if(status < thisStstus){
        backColor = Colors.grey;
        child = Text(title, style: const TextStyle(color: Colors.white),);
      }else if(status == thisStstus){
          backColor = Colors.blue;
          child = Stack(
            alignment: Alignment.center,
            children: [
              Text(title, style: const TextStyle(color: Colors.white),),
             const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )

            ],
          );
    }else{
        backColor = Colors.green;
        child = const Icon(Icons.check);
      }

      return Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: backColor,
            child: child,
          ),
          Text(subtitle)
        ],
      );
  }
}
