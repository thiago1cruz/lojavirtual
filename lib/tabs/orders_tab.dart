

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/login_screen.dart';
import 'package:lojavirtual/tiles/order_tile.dart';



class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

        if(UserModel.of(context).isLoggedIn()){
          String uid = UserModel.of(context).firebaseUser!.uid;
          return FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection('users').doc(uid)
              .collection('orders').get(),
              builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }else{
                    return ListView(
                      children: snapshot.data!.docs.map((e) => OrderTile(orderId: e.id)).toList()
                      .reversed.toList(),
                    );
                  }
              }
          );
        }else{
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.line_weight_sharp,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Faça o login para acompanhar!',
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
        }
  }
}
