import 'package:flutter/material.dart';
import 'package:perfume_store/models/routes.dart';
import 'package:perfume_store/models/user.dart';
import 'package:perfume_store/provider/user_provider.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "Required";
                } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                  return "Enter a valid email";
                }
                return null;
              },
              controller: _emailController,
              decoration: const InputDecoration(label: Text("Enter Email")),
            ),
            const SizedBox(height: 15),
            TextFormField(
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "Required";
                } else if (v.length < 8) {
                  return "Must be more than 8 characters";
                }
                return null;
              },
              controller: _passwordController,
              obscureText: obscurePassword,
              decoration: InputDecoration(
                label: const Text("Enter Password"),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                  icon: obscurePassword
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_key.currentState!.validate()) {
                  Map<String, dynamic> account =
                      await Provider.of<MyUserProvider>(context, listen: false).logInMyUser(
                          _emailController.text, _passwordController.text);

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(account['message'])));
                    if (account['status']) {
                      Navigator.pushNamed(context, Routes.homePage);
                    }
                  }
                }
              },
              child: const Text("Sign In"),
            ),
          ],
        ),
      ),
    );
  }
}
