import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onfly/shared/dialogs/alert_dialog.dart';
import 'package:onfly/shared/dialogs/loading.dart';

class LoginController {
  final BuildContext context;
  final Loading loading;
  final SimpleAlertDialog alert;
  LoginController({required this.context})
      : loading = Loading(context: context),
        alert = SimpleAlertDialog(context: context);

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: "teste@teste.com");
  final TextEditingController passwordController = TextEditingController(text: "Teste@123");
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  registerUser() async {
    try {
      loading.showLoading();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      loading.closeLoading();
    } on FirebaseAuthException catch (e) {
      loading.closeLoading();
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          alert.showAlert(
            closeButton: 'ok',
            title: 'Erro',
            message: 'A senha fornecida é muito fraca.',
          );
        }
      } else if (e.code == 'email-already-in-use') {
        alert.showAlert(
          closeButton: 'ok',
          title: 'Erro',
          message: 'Uma conta já existe para esse e-mail.',
        );
      } else {
        alert.showAlert(
          closeButton: 'ok',
          title: 'Erro',
          message: e.code,
        );
      }
    } catch (e) {
      loading.closeLoading();
      alert.showAlert(
        closeButton: 'ok',
        title: 'Erro inesperado',
        message: e.toString(),
      );
    }
  }

  login() async {
    try {
      loading.showLoading();
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);

      loading.closeLoading();
    } on FirebaseAuthException catch (e) {
      loading.closeLoading();
      if (e.code == 'user-not-found') {
        alert.showAlert(
          closeButton: 'ok',
          title: 'Erro',
          message: 'Nenhum usuário encontrado para esse e-mail',
        );
      } else if (e.code == 'wrong-password') {
        alert.showAlert(
          closeButton: 'ok',
          title: 'Erro',
          message: 'Senha errada fornecida para esse usuário.',
        );
      } else if (e.code == 'network-request-failed') {
        alert.showAlert(
          closeButton: 'OK',
          title: 'Sem conexão',
          message: 'Você está sem conexão e não está logado. Por favor, faça login assim que possível.',
        );
      } else {
        alert.showAlert(
          closeButton: 'ok',
          title: 'Erro',
          message: e.code,
        );
      }
    } catch (e) {
      loading.closeLoading();
      alert.showAlert(
        closeButton: 'ok',
        title: 'Erro inesperado',
        message: e.toString(),
      );
    }
  }

  validateForm(dynamic Function() function) {
    if (formKey.currentState!.validate()) {
      function();
    }
  }
}
