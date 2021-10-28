import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/login_screen.dart';
import 'package:lojavirtual/tiles/drawer_tiles.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  const CustomDrawer({Key? key, required this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBacker() => Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color.fromARGB(255, 203, 236, 241), Colors.white])),
        );

    return Drawer(
        child: Stack(children: [
      _buildDrawerBacker(),
      ListView(
        padding: const EdgeInsets.only(left: 32, top: 16),
        children: [
          Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.fromLTRB(0, 16, 16, 8),
              child:ScopedModelDescendant<UserModel>(
                builder: (context, child, model) =>
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Loja Virtual",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,                      
                      ),                  
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                      Text(
                      "Olá${!model.isLoggedIn()? '':", "+model.userData['name']}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     TextButton(
                       style: TextButton.styleFrom(
                         padding: const EdgeInsets.all(0), 
                         alignment: Alignment.centerLeft ),                      
                       child: Text(!model.isLoggedIn() ? 'Entre ou cadastre-se >' : 'Sair', 
                       style: TextStyle(color: Theme.of(context).primaryColor, 
                       fontSize: 16, fontWeight: 
                       FontWeight.bold),
                       textAlign: TextAlign.end,
                       ),
                       onPressed: (){
                         if(!model.isLoggedIn()){
                            Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=> LoginScreen()));
                         }else{
                           model.signOut();
                         }
                       },
                     )
                  ],
                ),
              )
              ),

              const Divider(),

              DrawerTile(icon: Icons.home, text: 'Início', controller: pageController,page: 0,),
              DrawerTile(icon: Icons.list, text: 'Produtos',controller: pageController,page: 1,),
              DrawerTile(icon: Icons.location_on, text: 'Lojas',controller: pageController,page: 2,),
              DrawerTile(icon: Icons.playlist_add_check, text: 'Meus Pedidos',controller: pageController,page: 3,),
        ],
      ),
    ])
    );
  }
}
