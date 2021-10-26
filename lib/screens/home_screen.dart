

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/tabs/category_tab.dart';
import 'package:lojavirtual/tabs/home_tab.dart';
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
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Produtos'),
            centerTitle: true,
          ),
          drawer:CustomDrawer(pageController: _pageController,),
          body: CategoryTab(),
        )
         
         
      ],
    );
  }
}