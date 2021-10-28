

import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/singup_screen.dart';
import 'package:scoped_model/scoped_model.dart';


class LoginScreen extends StatefulWidget {
   const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   final _emailController = TextEditingController();

   final _passController = TextEditingController();

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
                  MaterialPageRoute(builder: (context)=> const SingUpScreen())
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
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          if (model.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _emailController,
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
              controller: _passController,
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
                onPressed: (){
                  if (_emailController.text.isEmpty) {
                     ScaffoldMessenger.of(context)
                        .showSnackBar( const SnackBar(
                          content: Text('Insira o email para recuperação!', ),
                          backgroundColor: Colors.redAccent,
                          duration: Duration(seconds: 2),
                          ));
                  }else{
                    model.recoverPass(email: _emailController.text);
                     ScaffoldMessenger.of(context)
                        .showSnackBar(  SnackBar(
                          content: const Text('Confira seu email!', ),
                          backgroundColor: Theme.of(context).primaryColor,
                          duration: const Duration(seconds: 2),
                          )); 
                  }
                },
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
                    model.singIn(
                      email: _emailController.text,
                      pass: _passController.text,
                      onFail: _onFail,
                      onSuccess: _onSuccess
                    );
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
        ),
        );
        }
        )
    );
  }

   void _onSuccess(){   
        Navigator.of(context).pop();   
  }

  void _onFail(){
      ScaffoldMessenger.of(context)
    .showSnackBar( const SnackBar(
      content: Text('Falha na autenticação!', ),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
      ));  
    
  }
}