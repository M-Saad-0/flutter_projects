import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailortape/ui/widgets/custom_elevated_button.dart';
import 'package:tailortape/utils/helper_functions.dart';
import 'package:tailortape/utils/thememode_identifier.dart';
import 'package:tailortape/utils/toast_message.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ThememodeIdentifier().tell(context);
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "login");
          },
          child: const Icon(Icons.arrow_back_ios_new_sharp),
        ),
        title: const Text("Reset Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
                  label: Text("Enter Email"),
                  hintText: "your@email.com"),
              keyboardType: TextInputType.emailAddress,
            ),
            HelperFunctions().vSpace(25),
            MyElevatedButton(
              onPressed: () {
                _auth
                    .sendPasswordResetEmail(email: emailController.text)
                    .then((v) {
                  Message().give("You will receive an email shortly");
                }).onError((v, st) {
                  Message().give(v.toString());
                });
              },
              borderRadius: BorderRadius.circular(20),
              child: Text("Reset Password",
                  style: TextStyle(
                      color: isDarkMode ? Colors.black : Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
