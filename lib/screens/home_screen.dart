

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/tabs/category_tab.dart';
import 'package:lojavirtual/tabs/home_tab.dart';
import 'package:lojavirtual/tabs/orders_tab.dart';
import 'package:lojavirtual/tabs/places_tab.dart';
import 'package:lojavirtual/widgets/cart_button.dart';
import 'package:lojavirtual/widgets/custom_drawer.dart';


class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

   HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          body: const HomeTab(),
          drawer: CustomDrawer(pageController: _pageController,),
          floatingActionButton: const CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Produtos'),
            centerTitle: true,
          ),
          drawer:CustomDrawer(pageController: _pageController,),
          body: const CategoryTab(),
          floatingActionButton: const CartButton(),
        ),
        Scaffold(
         appBar: AppBar(
           title: Text('Lojas'),
           centerTitle: true,
         ),
          body: const PlacesTab(),
          drawer: CustomDrawer(pageController: _pageController,),
        ),

        Scaffold(
          appBar: AppBar(
            title: const Text('Meus Pedidos'),
            centerTitle: true,
          ),
          body:const OrdersTab(),
          drawer: CustomDrawer(pageController: _pageController,),
        )
         
         
      ],
    );
  }
}