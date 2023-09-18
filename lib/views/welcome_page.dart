import 'package:space_now/controller/access_controller.dart';
import 'package:space_now/views/home_page.dart';
import 'package:space_now/views/login_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState(){
    super.initState();
    AccessController.instance.verificarToken().then((hastoken){
      if(hastoken) {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => const HomePage(),)
          );
      } else {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => const LoginPage(),)
          );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(
              height: 20,
            ),
            Text("Carregando...")
          ],
        ),
      ),
    );
  }
}