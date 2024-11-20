// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:tailortape/utils/constants/test_styles.dart';
// import 'package:tailortape/utils/thememode_identifier.dart';

// class SplashView extends StatefulWidget {
//   const SplashView({super.key});

//   @override
//   State<SplashView> createState() => _SplashViewState();
// }

// class _SplashViewState extends State<SplashView> {
//   final _auth = FirebaseAuth.instance;
//   @override
//   void initState() {
//     super.initState();
//     _checkAccountAndThenRoute();
//   }

//   Future<void> _checkAccountAndThenRoute() async {
//     final data = await FirebaseFirestore.instance
//         .collection("Account")
//         .where("account", isEqualTo: _auth.currentUser!.uid)
//         .get();
//     debugPrint(data.docs[0].data()["account"]);
//     String accountType = data.docs[0].data()["account"];
//     User? user = _auth.currentUser;
//     if (user == null) {
//       Timer(const Duration(seconds: 2), () {
//         Navigator.pushNamedAndRemoveUntil(
//             context, "account_type", (Route<dynamic> route) => false);
//       });
//     } else {
//       if (accountType == "Tailor") {
//         Timer(const Duration(seconds: 2), () {
//           Navigator.pushNamedAndRemoveUntil(
//               context, "tailor", (Route<dynamic> route) => false);
//         });
//       } else if (accountType == "Customer") {
//         Timer(const Duration(seconds: 2), () {
//           Navigator.pushNamedAndRemoveUntil(
//               context, "customer", (Route<dynamic> route) => false);
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isDarkMode = ThememodeIdentifier().tell(context);

//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SvgPicture.asset(
//               "assets/icons/app_logo.svg",
//               width: 200,
//               height: 200,
//               colorFilter: ColorFilter.mode(
//                   isDarkMode
//                       ? const Color(0xff000000)
//                       : const Color(0xffffffff),
//                   BlendMode.srcIn),
//             ),
//             Text("Tailortape", style: TextStyles().style(900, 40))
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tailortape/utils/constants/test_styles.dart';
import 'package:tailortape/utils/thememode_identifier.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _checkAccountAndThenRoute();
  }

  Future<void> _checkAccountAndThenRoute() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        _navigateAfterDelay("account_type");
        return;
      }

      final data = await FirebaseFirestore.instance
          .collection("Account")
          .where("id", isEqualTo: user.uid)
          .get();

      if (data.docs.isEmpty) {
        debugPrint("No account found for the user.");
        return;
      }

      String accountType = data.docs[0].data()["account"];
      debugPrint("Account type: $accountType");

      if (accountType == "Tailor") {
        _navigateAfterDelay("tailor");
      } else if (accountType == "Customer") {
        _navigateAfterDelay("customer");
      } else {
        debugPrint("Unknown account type.");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void _navigateAfterDelay(String routeName) {
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, routeName, (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ThememodeIdentifier().tell(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/app_logo.svg",
              width: 200,
              height: 200,
              colorFilter: ColorFilter.mode(
                  !isDarkMode
                      ? const Color(0xff000000)
                      : const Color(0xffffffff),
                  BlendMode.srcIn),
            ),
            Text("Tailortape", style: TextStyles().style(900, 40))
          ],
        ),
      ),
    );
  }
}
