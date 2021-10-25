import 'package:flutter/material.dart';
import 'package:lojavirtual/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loja Virtual',
      theme: ThemeData(      
        primarySwatch: Colors.blue,
        primaryColor: const Color.fromARGB(255, 4, 125, 141)
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

