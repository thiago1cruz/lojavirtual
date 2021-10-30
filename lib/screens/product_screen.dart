
import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/data/cart_product.dart';
import 'package:lojavirtual/data/product_data.dart';
import 'package:lojavirtual/models/cart_model.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/login_screen.dart';

import 'cart_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData data;

  const ProductScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState(data);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData data;
  String? size;
  _ProductScreenState(this.data);
  
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: data.images.map((e) => NetworkImage(e)).toList(),
              dotSize: 4,
              dotSpacing: 15,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  'R\$ ${data.price.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Tamanho',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 34,
                  child: GridView(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.5),
                    children: data.sizes
                        .map((e) => GestureDetector(
                          onTap: (){
                           setState(() {
                              size = e;
                           });
                          },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:  const BorderRadius.all(
                                        Radius.circular(4)),
                                    border: Border.all(
                                        width: 2, 
                                        color: e == size ? primaryColor : Colors.grey)),
                                width: 50,
                                alignment: Alignment.center,
                                child: Text(e),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 16 ,),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    style:ElevatedButton.styleFrom(
                        primary: primaryColor,
                        onSurface: Colors.grey,
                        elevation: 7,
                        shadowColor: Colors.blue,
                      ),
                    onPressed: size != null  ? (){
                      if (UserModel.of(context).isLoggedIn()) {

                        CartProduct cartProduct = CartProduct();
                           cartProduct.size = size!;
                           cartProduct.quantity = 1;
                           cartProduct.pid = data.id;
                           cartProduct.category = data.category; 
                        CartModel.of(context).addCartItem(cartProduct);
                         Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>const CartScreen())
                        );
                      }else{
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>const LoginScreen())
                        );
                      }
                    } : null,                    
                    child:  Text(UserModel.of(context).isLoggedIn()?'Adicionar ao carrinho'
                                  :'Entre para Comprar',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,                      
                    ),
                    ) ,
                  ),
                ),
                const SizedBox(height: 16 ,),
                 const Text(
                  'Descrição',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  data.description,
                  style: const TextStyle(
                    fontSize: 16, 
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
