

import 'package:flutter/material.dart';
import 'package:lojavirtual/screens/singup_screen.dart';


class LoginScreen extends StatelessWidget {
   LoginScreen({ Key? key }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true ,
        actions: [
          ElevatedButton(
            onPressed: (){
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context)=> SingUpScreen())
              );
            },
            style: ElevatedButton.styleFrom(elevation: 0), 
            child: const Text('CRIAR CONTA',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white
              ),
            )
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              validator: (text){
                  if(text!.isEmpty || !text.contains('@')) return 'Email inválido!';
              },
              decoration: const InputDecoration(
                hintText: 'Email'
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16,),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Senha'
              ),
              obscureText: true,
              validator: (text){
                if(text!.isEmpty || text.length < 6) return 'A senha precisa conter 6 caractere';
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,                            
                  ),                
                onPressed: (){},
                child: const Text('Esqueci minha senha',
                  textAlign: TextAlign.right,
                  ),
              ),
            ),
            const SizedBox(height: 16,),
            SizedBox(
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor
                ),
                onPressed: (){
                  if(_formKey.currentState!.validate()){

                  }
                }, 
                child: const Text('Entrar',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
                ),
                )
                ),
            )
          ],
        ),),
    );
  }
}