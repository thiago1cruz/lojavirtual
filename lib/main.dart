import 'package:flutter/material.dart';
import 'package:lojavirtual/models/cart_model.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scoped_model/scoped_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(), 
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) =>  ScopedModel<CartModel>(
        model: CartModel(user: model),
        child: MaterialApp(
      title: 'Loja Virtual',
      theme: ThemeData(      
        primarySwatch: Colors.blue,
        primaryColor: const Color.fromARGB(255, 4, 125, 141)
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
    )
      )
      );
  }
}

