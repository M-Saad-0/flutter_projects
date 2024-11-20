import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailortape/ui/widgets/custom_elevated_button.dart';
import 'package:tailortape/utils/helper_functions.dart';
import 'package:tailortape/utils/thememode_identifier.dart';

class AcountTypeView extends StatelessWidget {
  const AcountTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ThememodeIdentifier().tell(context);
    FirebaseAuth _auth = FirebaseAuth.instance;

    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: [
                Text("You can try these demo accounts for "),
                InkWell(
                  onTap: () async {
                    await _auth.signInWithEmailAndPassword(
                        email: "msad@gmail.com", password: "1234567");
                    Navigator.pushNamedAndRemoveUntil(
                        context, "tailor", (Route<dynamic> route) => false);
                  },
                  child: Text(
                    "Tailor",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Text(" and "),
                InkWell(
                  onTap: () async {
                    await _auth.signInWithEmailAndPassword(
                        email: "azhar@gmail.com", password: "password");
                    Navigator.pushNamedAndRemoveUntil(
                        context, "customer", (Route<dynamic> route) => false);
                  },
                  child: Text(
                    "Customer",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Text(" with some dummy data."),
              ],
            ),
          ),
          HelperFunctions().vSpace(150),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Choose Your Role in This App",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
                SizedBox(height: 20),
                MyElevatedButton(
                  height: 50,
                  width: 300,
                  borderRadius: BorderRadius.circular(10),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      "signup_customer",
                    );
                  },
                  child: Text(
                    'Create Customer Account',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: isDarkMode ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                const Text("Or"),
                SizedBox(height: 10),
                MyElevatedButton(
                  height: 50,
                  width: 300,
                  borderRadius: BorderRadius.circular(10),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      "signup",
                    );
                  },
                  child: Text(
                    'Create Tailor Account',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: isDarkMode ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
