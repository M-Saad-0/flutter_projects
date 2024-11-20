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

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final collections = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    // final GoogleSignIn _googleSignIn = GoogleSignIn();
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
                        text: "Sign up now as a Tailor",
                        duration: const Duration(milliseconds: 150)),
                    builder: (context, value) {
                      return Center(
                        child: Text(value.text,
                            style: TextStyles().style(900, 20)),
                      );
                    }),
                HelperFunctions().vSpace(70),
                Form(
                  key: key,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            hintText: "First Name",
                            label: const Text("First Name"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2.0,
                                    style: BorderStyle.solid))),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Enter first name";
                          }
                          return "";
                        },
                      ),
                      HelperFunctions().vSpace(15),
                      TextFormField(
                        controller: lastNameController,
                        // obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.last_page),
                            hintText: "Last name",
                            label: const Text("Last name"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2.0,
                                    style: BorderStyle.solid))),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Enter last name";
                          }
                          return "";
                        },
                      ),
                      HelperFunctions().vSpace(15),
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
                                    width: 2.0, style: BorderStyle.solid))),
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
                                    width: 2.0, style: BorderStyle.solid))),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Enter password";
                          }
                          return "";
                        },
                      ),
                      HelperFunctions().vSpace(50),
                      Consumer<LoadingProvider>(
                          builder: (context, value, child) {
                        return MyElevatedButton(
                            borderRadius: BorderRadius.circular(20),
                            onPressed: () async {
                              value.serIsLoading(true);
                              try {
                                UserCredential user =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text);
                                if (user.user != null) {
                                  await collections
                                      .collection("Tailor")
                                      .doc(user.user?.uid)
                                      .set({
                                    "first_name": firstNameController.text,
                                    "last_name": lastNameController.text,
                                    "tailor_id": _auth.currentUser!.uid,
                                    "cost": 800,
                                  });
                                  await collections
                                      .collection("Account")
                                      .doc(user.user!.uid)
                                      .set({
                                    "account": "Tailor",
                                    "id": user.user!.uid
                                  });
                                  value.serIsLoading(false);

                                  if (context.mounted) {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        'tailor',
                                        (Route<dynamic> route) => false);
                                  }
                                }
                              } on FirebaseAuthException catch (e) {
                                Message().give(e.code);
                              }
                            },
                            width: 250,
                            height: 50,
                            child: Text(
                              "Create Account",
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
                      //         final UserCredential userCredential =
                      //             await _auth.signInWithCredential(credential);

                      //         final User? user = userCredential.user;
                      //         final name = user!.displayName!.split(" ");
                      //         await collections
                      //             .collection("Tailor")
                      //             .doc(user.uid)
                      //             .set({
                      //           "first_name": name[0],
                      //           "last_name": name[1],
                      //         });
                      //         await collections
                      //             .collection("Account")
                      //             .doc(user.uid)
                      //             .set({"account": "Tailor", "id": user.uid});
                      //         if (context.mounted) {
                      //           Navigator.pushNamedAndRemoveUntil(context,
                      //               'tailor', (Route<dynamic> route) => false);
                      //         }
                      //       }
                      //     },
                      //     width: 250,
                      //     height: 50,
                      //     child: Text(
                      //       "Sign Up with Google",
                      //       style: TextStyle(
                      //           color:
                      //               isDarkMode ? Colors.white : Colors.black),
                      //     )),
                      HelperFunctions().vSpace(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  'login', (Route<dynamic> route) => false);
                            },
                            child: Text(
                              "Sign In",
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
