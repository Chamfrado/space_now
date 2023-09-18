import 'package:space_now/components/form_text_field.dart';
import 'package:space_now/controller/access_controller.dart';
import 'package:space_now/views/home_page.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        leading: GFIconButton(
          icon: const Icon(
            Icons.rocket,
            color: Colors.white,
          ),
          onPressed: () {},
          type: GFButtonType.transparent,
        ),
        title: Text("Space Now"),
        backgroundColor: GFColors.DARK,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GFCard(
              boxFit: BoxFit.cover,
              titlePosition: GFPosition.start,
              content: Form(
                key: _formKey,
                child: Column(
                  children: [
                    FormTextField(
                      textController: _emailController,
                      hintText: 'email',
                      labelText: 'email',
                      iconInput: Icon(Icons.badge),
                      inputValidator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Por favor, preencha o campo usuário';
                        }
                        return null;
                      },
                    ),
                    FormTextField(
                      textController: _passwordController,
                      hintText: 'senha',
                      labelText: 'senha',
                      iconInput: Icon(Icons.security),
                      obscureText: true,
                      inputValidator: (passwd) {
                        if (passwd == null || passwd.isEmpty) {
                          return 'Por favor, preencha o campo senha';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GFButton(
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        final messenger = ScaffoldMessenger.of(context);

                        if (_formKey.currentState!.validate()) {
                          bool loginSuccess = await AccessController.instance
                              .login(_emailController.text,
                                  _passwordController.text);

                          if (loginSuccess) {
                            navigator.pushReplacement(MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ));
                          } else {
                            messenger.showSnackBar(const SnackBar(
                              content: Text('Usuario e/ou senha incorretos'),
                              backgroundColor: GFColors.DANGER,
                            ));
                          }
                        }
                      },
                      text: 'Login',
                      fullWidthButton: true,
                      color: GFColors.DARK,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
