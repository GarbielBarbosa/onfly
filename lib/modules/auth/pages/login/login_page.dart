import 'package:flutter/material.dart';
import 'package:onfly/modules/auth/pages/login/login_controller.dart';
import 'package:onfly/shared/theme/colors.dart';
import 'package:onfly/shared/validators/text_validator.dart';
import 'package:onfly/shared/widgets/custom_form_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    final LoginController controller = LoginController(context: context);
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/static_images/plane.jpeg'),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                              color: DefaultColors().background,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/static_images/onfly-logo.webp',
                                    height: 35,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Form(
                                    key: controller.formKey,
                                    child: Column(
                                      children: [
                                        CustomFormField(
                                          controller: controller.emailController,
                                          focusNode: controller.emailFocus,
                                          textInputAction: TextInputAction.next,
                                          label: 'Email',
                                          hintText: 'email',
                                          keyboardType: TextInputType.emailAddress,
                                          validator: (e) {
                                            return Validators().email(e ?? '');
                                          },
                                          prefixIcon: const Icon(Icons.person),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        CustomFormField(
                                          controller: controller.passwordController,
                                          focusNode: controller.passwordFocus,
                                          textInputAction: TextInputAction.done,
                                          label: 'Senha',
                                          hintText: 'senha',
                                          obscureText: obscurePassword,
                                          prefixIcon: const Icon(Icons.lock_rounded),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                obscurePassword = !obscurePassword;
                                              });
                                            },
                                            child: obscurePassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                                          ),
                                          validator: (e) {
                                            return Validators().validatePassword(e ?? '');
                                          },
                                          onEditingComplete: () {
                                            controller.validateForm(() => controller.login());
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        controller.validateForm(() => controller.login());
                                      },
                                      child: const Text('Entrar'),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () => {controller.validateForm(() => controller.registerUser())},
                                      child: const Text('Registar e entrar'),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
