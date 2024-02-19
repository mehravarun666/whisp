import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(16),
      child: Form(
        key:  formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You will recieve an email\n to reset password',style: TextStyle(),),
            SizedBox(height: 20,),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email)=>email != null && !EmailValidator.validate(email)?'Enter a valid email': null,
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  hintText: 'Enter email id as abc@gmail.com'),
            ),
            SizedBox(height: 20,),
            ElevatedButton.icon(onPressed:resetPassword, icon: Icon(Icons.mail_outline_sharp), label: Text('Reset Password',style: TextStyle(fontSize: 20),))
          ],
        ),
      ),)
    );
  }
  Future resetPassword()async{

    showDialog(context: context,barrierDismissible: false, builder: (context)=>Center(child: CircularProgressIndicator(),));
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password Reset Email Sent'),
        ),
      );
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'An error occurred during Reset.'),
        ),
      );
      Navigator.of(context).pop();
    }
  }
}
