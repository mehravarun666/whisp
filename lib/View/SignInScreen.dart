import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SignInScreen extends StatefulWidget {

  final VoidCallback login;
  SignInScreen({Key? key, required this.login}):super(key:key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController CheckpasswordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFDFA),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Center(
                    child: Container(
                        width: 400,
                        height: 400,
                        /*decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50.0)),*/
                        child: Image.asset('assets/Images/Whisp_banner.png',)),
                  ),
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email)=>email != null && !EmailValidator.validate(email)?'Enter a valid email': null,
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                        hintText: 'Enter email id as abc@gmail.com'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value)=>value != null && value.length<6?'Password must contains more than 6 characters':null,
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value)=>value != null && passwordController.text!=CheckpasswordController.text?'Password must contains more than 6 characters':null,
                    controller: CheckpasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                  ),
                ),

                SizedBox(
                  height: 65,
                  width: 360,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ElevatedButton(
                        child: Text( 'Sign Up ', style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        onPressed:signUp,

                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Container(
                    child:  Row(
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left: 62),
                          child: Container(height:40,child: Text("Already have an account ?" )),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: InkWell(
                              onTap: (){
                                widget.login();
                                print('tapped on signin screen');
                              },
                              child: Container(height:40,width:50,child: Text('Log in', style: TextStyle(fontSize: 14, color: Colors.blue),))),
                        )
                      ],
                    ),

                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  Future<void> signUp() async {

    final isValid = formKey.currentState!.validate();
    if(!isValid) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'An error occurred during sign up.'),
        ),
      );
    } finally {
      Navigator.of(context).pop();
    }
  }

}
