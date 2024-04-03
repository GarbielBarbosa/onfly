import 'package:flutter/material.dart';
import 'package:onfly/modules/auth/pages/login/login_controller.dart';
import 'package:onfly/shared/validators/text_validator.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final LoginController controller = LoginController(context: context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        key: const Key('email'),
                        controller: controller.emailController,
                        focusNode: controller.emailFocus,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (e) {
                          return Validators().email(e ?? '');
                        },
                      ),
                      TextFormField(
                          key: const Key('senha'),
                          controller: controller.passwordController,
                          focusNode: controller.passwordFocus,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            hintText: 'senha',
                          ),
                          validator: (e) {
                            return Validators().validatePassword(e ?? '');
                          },
                          onEditingComplete: () {
                            controller.validateForm(() => controller.registerUser());
                          }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.validateForm(() => controller.login());
                      //context.go('/details')
                    },
                    child: const Text('Entrar'),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () => {controller.validateForm(() => controller.registerUser())},
                    child: const Text('Registar e entrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
