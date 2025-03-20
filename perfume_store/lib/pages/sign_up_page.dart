import 'package:flutter/material.dart';
import 'package:perfume_store/models/routes.dart';
import 'package:perfume_store/models/user.dart';
import 'package:perfume_store/pages/sign_in_page.dart';
import 'package:perfume_store/provider/user_provider.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 550,
          width: MediaQuery.sizeOf(context).width > 412 ? 600 : 380,
          child: Card(
              // color: Theme.of(context).colorScheme.tertiary,
              child: Column(
            children: [
              TabBar(controller: controller, tabs: const [
                Tab(
                  text: "Sign Up",
                ),
                Tab(
                  text: "Sign In",
                )
              ]),
              const SizedBox(
                height: 8,
              ),
              Image.asset(
                "assets/images/logo.jpg",
                height: 140,
              ),
              Expanded(
                  child: TabBarView(
                      controller: controller,
                      children: const [SignUpPage(), SignInPage()])),
            ],
          )),
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool obscurePassword = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                controller: _nameController,
                decoration:
                    const InputDecoration(label: Text("Enter Full Name")),
              ),
              const SizedBox(height: 15),
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
                    return "Must be more that 8 characters";
                  } else {
                    return null;
                  }
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
                          : const Icon(Icons.visibility_off)),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Required";
                  } else if (v.length < 8) {
                    return "Must be more that 8 characters";
                  } else {
                    return null;
                  }
                },
                controller: _addressController,
                decoration:
                    const InputDecoration(label: Text("Enter Your Address")),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      Map<String, dynamic> account =
                          await Provider.of<MyUserProvider>(context,
                                  listen: false)
                              .setMyUser(
                                  MyUser(
                                      name: _nameController.text,
                                      address: _addressController.text,
                                      email: _emailController.text),
                                  _passwordController.text);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(account['message'])));
                      }
                      if (account['status']) {
                        if (context.mounted) {
                          Navigator.pushNamed(context, Routes.homePage);
                        }
                      }
                    }
                  },
                  child: const Text("Sign Up"))
            ],
          ),
        ),
      ),
    );
  }
}
