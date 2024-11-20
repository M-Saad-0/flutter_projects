import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:tailortape/provider/theme_provider.dart';
import 'package:tailortape/ui/widgets/custome_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tailortape/utils/toast_message.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleAuth = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeDataModel, child) {
      void systemFunction() async {
        themeDataModel.setSystemTheme(
            themeDataModel.sysThemeCheck == Icons.radio_button_off_sharp
                ? Icons.radio_button_checked_sharp
                : Icons.radio_button_checked_sharp);
        themeDataModel.setTheme(ThemeMode.system);
        themeDataModel.setThemeIcon(Icons.system_update_sharp);
        themeDataModel.setThemeName("Using System");
      }

      void themeFunction() async {
        final iconData = themeDataModel.themeName == "Light"
            ? Icons.dark_mode
            : Icons.light_mode;
        final themeMode = themeDataModel.themeMode == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light;
        debugPrint(themeDataModel.themeMode.toString());
        final themeName =
            themeDataModel.themeName == "Light" ? "Dark" : "Light";
        themeDataModel.setThemeIcon(iconData);
        themeDataModel.setTheme(themeMode);
        themeDataModel.setThemeName(themeName);
        themeDataModel.setSystemTheme(Icons.radio_button_off_sharp);
      }

      void signOut() async {
        if (_auth.currentUser?.providerData[0].providerId == 'google.com') {
          // await _googleAuth.signOut();
        } else {
          await _auth.signOut();
        }
        Message().give("Logged out");

        if (context.mounted) {
          Navigator.of(context).pushReplacementNamed('login');
        }
      }

      void deleteUser() async {
        final data = await FirebaseFirestore.instance
            .collection("Account")
            .where("id", isEqualTo: _auth.currentUser!.uid)
            .get();
        String type = data.docs[0].data()["account"];

        if (type == "Customer") {
          final collectionRef = _firestore.collection('Customer');
          final querySnapshot = await collectionRef
              .where('email', isEqualTo: _auth.currentUser!.email)
              .get();

          for (var doc in querySnapshot.docs) {
            await doc.reference.delete();
          }
        } else if (type == "Tailor") {
          final collectionRef = _firestore.collection('Tailor');
          final querySnapshot = await collectionRef
              .where('tailor_id', isEqualTo: _auth.currentUser!.uid)
              .get();

          for (var doc in querySnapshot.docs) {
            await doc.reference.delete();
          }
        }

        _auth.currentUser!.delete();
        Message().give("Account Deleted");
        if (context.mounted) {
          Navigator.of(context).pushReplacementNamed('login');
        }
      }

      List<Widget> list = [
        MyListTile(
          title: "${themeDataModel.themeName} theme",
          trailing: themeDataModel.themeIcon,
          onTap: themeFunction,
        ),
        MyListTile(
          title: "Use System Theme",
          trailing: themeDataModel.sysThemeCheck,
          onTap: systemFunction,
        ),
        MyListTile(
          title: "Log Out",
          trailing: Icons.logout,
          onTap: signOut,
        ),
        MyListTile(
          title: "Delete Account",
          trailing: Icons.delete,
          onTap: deleteUser,
        ),
      ];

      return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.settings),
          title: const Text("Settings"),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) => Card(child: list[index])),
            ),
          ],
        ),
      );
    });
  }
}
