import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:tailortape/provider/loading_provider.dart';
import 'package:tailortape/ui/widgets/custom_elevated_button.dart';
// import 'package:tailortape/ui/widgets/custom_google_button.dart';
import 'package:tailortape/utils/constants/test_styles.dart';
import 'package:tailortape/utils/helper_functions.dart';
import 'package:tailortape/utils/thememode_identifier.dart';
import 'package:tailortape/utils/toast_message.dart';
import 'package:typewritertext/typewritertext.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    // final GoogleSignIn _googleSignIn = GoogleSignIn();
    final _auth = FirebaseAuth.instance;
    GlobalKey key = GlobalKey<FormState>();
    bool isDarkMode = ThememodeIdentifier().tell(context);

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SvgPicture.asset(
                    "assets/icons/app_logo.svg",
                    width: 100,
                    height: 100,
                    colorFilter: ColorFilter.mode(
                        isDarkMode
                            ? const Color(0xffffffff)
                            : const Color(0xff000000),
                        BlendMode.srcIn),
                  ),
                  HelperFunctions().hSpace(5),
                  TypeWriter(
                      controller: TypeWriterController(
                          text: "Tailortape",
                          duration: const Duration(milliseconds: 50)),
                      builder: (context, value) {
                        return Center(
                            child: Text(value.text,
                                style: TextStyles().style(900, 40)));
                      }),
                ]),
                TypeWriter(
                    controller: TypeWriterController(
                        text: "Log In Now",
                        duration: const Duration(milliseconds: 150)),
                    builder: (context, value) {
                      return Center(
                        child: Text(value.text,
                            style: TextStyles().style(900, 30)),
                      );
                    }),
                HelperFunctions().vSpace(100),
                Form(
                  key: key,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            hintText: "Email",
                            label: const Text("Email"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2.0,
                                    style: BorderStyle.solid))),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Enter email";
                          }
                          return "";
                        },
                      ),
                      HelperFunctions().vSpace(15),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            hintText: "Password",
                            label: const Text("Password"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2.0,
                                    style: BorderStyle.solid))),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Enter password";
                          }
                          return "";
                        },
                      ),
                      HelperFunctions().vSpace(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                "forgot_password",
                              );
                            },
                            child: Text(
                              "Forgot Password",
                              style: TextStyles().style(200, 15),
                            ),
                          )
                        ],
                      ),
                      HelperFunctions().vSpace(50),
                      Consumer<LoadingProvider>(builder: (context, v, child) {
                        return MyElevatedButton(
                            borderRadius: BorderRadius.circular(20),
                            onPressed: () async {
                              v.serIsLoading(true);

                              try {
                                await _auth.signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text);
                              } on FirebaseAuthException catch (e) {
                                Message().give(e.code);
                              }
                              final data = await FirebaseFirestore.instance
                                  .collection("Account")
                                  .where("id",
                                      isEqualTo: _auth.currentUser!.uid)
                                  .get();
                              String accountType =
                                  data.docs[0].data()["account"];
                              debugPrint(accountType);
                              if (accountType == "Tailor") {
                                if (context.mounted) {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      'tailor',
                                      (Route<dynamic> route) => false);
                                }
                              } else if (accountType == "Customer") {
                                if (context.mounted) {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      'customer',
                                      (Route<dynamic> route) => false);
                                }
                              }
                            },
                            width: 250,
                            isLoading: v.isLoading,
                            height: 50,
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  color:
                                      isDarkMode ? Colors.black : Colors.white),
                            ));
                      }),
                      // HelperFunctions().vSpace(15),
                      // const Text("or"),
                      // HelperFunctions().vSpace(15),
                      // GoogleButton(
                      //     borderRadius: BorderRadius.circular(20),
                      //     onPressed: () async {
                      //       final GoogleSignInAccount? googleUser =
                      //           await _googleSignIn.signIn();
                      //       if (googleUser == null) {
                      //         Message().give(" - ");
                      //       } else {
                      //         final GoogleSignInAuthentication googleAuth =
                      //             await googleUser.authentication;
                      //         final AuthCredential credential =
                      //             GoogleAuthProvider.credential(
                      //                 accessToken: googleAuth.accessToken,
                      //                 idToken: googleAuth.idToken);
                      //         await _auth.signInWithCredential(credential);
                      //         final data = await FirebaseFirestore.instance
                      //             .collection("Account")
                      //             .where("id",
                      //                 isEqualTo: _auth.currentUser!.uid)
                      //             .get();
                      //         debugPrint(data.docs[0].data()["account"]);
                      //         String accountType =
                      //             data.docs[0].data()["account"];

                      //         if (accountType == "Tailor") {
                      //           if (context.mounted) {
                      //             Navigator.pushNamedAndRemoveUntil(
                      //                 context,
                      //                 'tailor',
                      //                 (Route<dynamic> route) => false);
                      //           }
                      //         } else if (accountType == "Customer") {
                      //           if (context.mounted) {
                      //             Navigator.pushNamedAndRemoveUntil(
                      //                 context,
                      //                 'customer',
                      //                 (Route<dynamic> route) => false);
                      //           }
                      //         }
                      //       }
                      //     },
                      //     width: 250,
                      //     height: 50,
                      //     child: Text(
                      //       "Sign In with Google",
                      //       style: TextStyle(
                      //           color:
                      //               isDarkMode ? Colors.white : Colors.black),
                      //     )),
                      HelperFunctions().vSpace(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  "account_type",
                                  (Route<dynamic> route) => false);
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyles().style(600, 20),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
