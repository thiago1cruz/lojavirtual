

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual/data/product_data.dart';



class CartProduct {
  late String cid;
  late String category;
  late String pid;

  late int quantity;
  late String size;

  ProductData? productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot docment){
      cid = docment.id;
      category = docment.get('category');
      pid = docment.get('pid');
      quantity = docment.get('quantity');
      size = docment.get('size');
  }

  Map<String, dynamic> toMap() => {
      'category':category,
      'pid': pid,      
      'quantity':quantity,
      'size':size,
      'product': productData!.toResumedMap()

  };
}