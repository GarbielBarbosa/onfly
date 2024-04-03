import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onfly/firebase_options.dart';
import 'package:onfly/routes.dart';
import 'package:onfly/shared/services/firebase_auth_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Função assíncrona para inicializar o Firebase antes de construir o widget
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Chama a função para inicializar o Firebase
    return FutureBuilder(
      future: initializeFirebase(),
      builder: (context, snapshot) {
        // Verifica se houve algum erro na inicialização do Firebase
        if (snapshot.connectionState == ConnectionState.done) {
          // Se a inicialização foi concluída, retorna o MaterialApp
          return MaterialApp.router(
            routerConfig: router,
          );
        } else {
          // Caso contrário, exibe uma tela de carregamento ou mensagem de espera
          return CircularProgressIndicator(); // Ou outro widget de carregamento
        }
      },
    );
  }
}
