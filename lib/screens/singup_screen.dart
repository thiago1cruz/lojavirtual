
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';


class SingUpScreen extends StatefulWidget {

  const SingUpScreen({ Key? key }) : super(key: key);

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _enderecoController = TextEditingController();

   final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true ,        
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context,child,model){
          if (model.isLoading) {
              return const Center(child: CircularProgressIndicator(),);            
          }
          return Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              validator: (text){
                  if(text!.isEmpty) return 'Nome Inválido!';
              },
              decoration: const InputDecoration(
                hintText: 'Nome Completo'
              ),
            ),
             const SizedBox(height: 16,),
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
              controller: _senhaController,
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
              controller: _enderecoController,
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
                    Map<String,dynamic> userData = {
                        'name':_nameController.text,
                        'email': _emailController.text,
                        'address': _enderecoController.text
                    };

                    model.singUp(
                      userData: userData, 
                      pass: _senhaController.text, 
                      onSucsess: _onSuccess, 
                      onFail: _onFail
                      );
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
        ),);
        },
      )
    );
  }

  void _onSuccess(){
    ScaffoldMessenger.of(context)
    .showSnackBar( SnackBar(
      content: const Text('Usuário Criado com sucesso!', ),
      backgroundColor: Theme.of(context).primaryColor,
      duration: const Duration(seconds: 2),
      ));  
      Future.delayed(const Duration(seconds: 2)).then((_){
        Navigator.of(context).pop();
      });  
  }

  void _onFail(){
      ScaffoldMessenger.of(context)
    .showSnackBar( const SnackBar(
      content: Text('Falh ao criar usuário  !', ),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
      ));  
    
  }
}