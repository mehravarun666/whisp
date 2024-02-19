
import 'package:flutter/cupertino.dart';
import 'package:whisp/View/LoginScreen.dart';
import 'package:whisp/View/SignInScreen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin?
  LoginDemo(signUp: toggle,):
  SignInScreen(login: toggle,);

  void toggle()=>setState(() {
    isLogin = !isLogin;
  });
}
