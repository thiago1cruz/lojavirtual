

import 'package:flutter/material.dart';
import 'package:lojavirtual/data/product_data.dart';


class ProductScreen extends StatefulWidget {

   final ProductData data;

  const ProductScreen({ Key? key, required this.data }) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}