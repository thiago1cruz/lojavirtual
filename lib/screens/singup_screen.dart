
import 'package:flutter/material.dart';


class SingUpScreen extends StatelessWidget {

  SingUpScreen({ Key? key }) : super(key: key);

   final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true ,        
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              validator: (text){
                  if(text!.isEmpty) return 'Nome Inválido!';
              },
              decoration: const InputDecoration(
                hintText: 'Nome Completo'
              ),
            ),
             const SizedBox(height: 16,),
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
            const SizedBox(height: 16,),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Endereço'
              ),  
              validator: (text){
                if(text!.isEmpty) return 'Endereço inválido!';
              },
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
                child: const Text('Criar',
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