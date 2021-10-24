# lojavirtual

This project aims at a mobile application, developed in hybrid language through FLUTTER user interface development kit.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

 Create project in Firebase, link da página logo a baixo.
 - https://console.firebase.google.com/u/2/
 * De pois que o projeto foi criado vá em autenticação e ative o método de autenticação por email e senha.
 * Vá em FireStore Database e crie seu banco de dados
 coloque -o em modo de produção, mais para isso adicione as regras para que seu banco de dados mão seja vulnerável. Ou se preferir pode colocar em modo de teste para apenas poder testar.
  - Link de como configurar as regras.
  {deixar as regras pesquita aqui}

  *Configure seu app, ainda no firebase vá em  Visão Geral do Projeto, clique no para ciração de app android . Abra o projeto em sua IDE preferida, vá no diretório: "/android/app/src/main/" AndroidManifest.xml. e copie o package, que é igual a "br.com.lojavirtual.lojavirtual" [coloque sem as aspas]. Colo onde está escrito "Nome do pacote do Android", dê um apelido, e clique em registrar app.
  * Faça o download do "google-services.json" copie e colo o arquivo dentro da pasta "/android/app" assim como descrito na página de download do arquivo. Clique em próximo.
  
  No seu projeto abra o seguinte arquivo no diretório: "android/app/build.gradle". vá para onde  contém o trechos de código a seguir "apply plugin: 'com.android.application'" e cole  o seguinte "apply plugin: 'com.google.gms.google-services'", apenas com as aspas simples. Esse projeto já com tem esse código porém é bom saber o processo. Esse código que foi colado está especificado na etapa 3 da página "Adicionar o Firebase ao seu app Android". Seguindo o mesmo processo cole o seguinte trecho de código obtido nessa mesma página "classpath 'com.google.gms:google-services:4.3.10'" em "android/build.gradle" dentro de "dependencies"  abaixo do "classpath 'com.android.tools.build:gradle:4.1.0'". Depois de tudo clique em "próximo" e em "Continuar no console".

