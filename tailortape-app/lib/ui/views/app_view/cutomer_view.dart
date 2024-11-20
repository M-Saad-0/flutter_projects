import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tailortape/ui/views/payment.dart';
import 'package:tailortape/ui/views/settings/setting_view.dart';
import 'package:tailortape/ui/widgets/custom_elevated_button.dart';
import 'package:tailortape/utils/constants/test_styles.dart';
import 'package:tailortape/utils/thememode_identifier.dart';
import 'package:tailortape/utils/toast_message.dart';

class CustomerView extends StatefulWidget {
  const CustomerView({super.key});

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  final User? user = FirebaseAuth.instance.currentUser;
  final snapshot = FirebaseFirestore.instance.collection("Order").snapshots();
  int cost = 0;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ThememodeIdentifier().tell(context);
    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset(
          "./icons/app_logo.svg",
          colorFilter: ColorFilter.mode(
            !isDarkMode ? const Color(0xff000000) : const Color(0xffffffff),
            BlendMode.srcIn,
          ),
        ),
        title: const Text("My Orders"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Card(
                  child: ListTile(
                    title: const Text("Settings"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingView(),
                        ),
                      );
                    },
                    leading: const Icon(Icons.settings),
                  ),
                ),
              ),
              PopupMenuItem(
                child: Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (context) => SizedBox(
                          height: 300,
                          child: AlertDialog(
                            title: Row(
                              children: [
                                SvgPicture.asset(
                                  width: 70,
                                  height: 70,
                                  "./icons/app_logo.svg",
                                  colorFilter: ColorFilter.mode(
                                    !isDarkMode
                                        ? const Color(0xff000000)
                                        : const Color(0xffffffff),
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const Text("Tailortape"),
                              ],
                            ),
                            content: Container(
                              height: 150,
                              child: const Column(
                                children: [
                                  Text("App Version:  1.0.0"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Made By",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Muhammad Saad   21pwcse1997"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Muhammad Umar Jan   21pwcse2000"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Kashif Alam   21pwcse1979"),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Close"),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    title: const Text("About"),
                    leading: const Icon(Icons.info),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder(
        stream: snapshot,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var orderData = snapshot.data!.docs[index];
                      if (user!.email == orderData["customer_id"]) {
                        return FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection("Tailor")
                              .doc(orderData["tailor_id"])
                              .get(),
                          builder: (context, tailorSnapshot) {
                            if (tailorSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Card(
                                child: ListTile(
                                  title: Text("Loading..."),
                                ),
                              );
                            } else if (tailorSnapshot.hasError) {
                              Message().give("Error Loading The Data");
                              return const Card(
                                child: ListTile(
                                  title: Text("Error..."),
                                ),
                              );
                            } else if (tailorSnapshot.hasData &&
                                tailorSnapshot.data != null) {
                              cost = tailorSnapshot.data!["cost"];
                              return Card(
                                child: ListTile(
                                  leading: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: stringToColor(orderData["color"]),
                                    ),
                                  ),
                                  title: Text(
                                    "${tailorSnapshot.data!["first_name"]} ${tailorSnapshot.data!["last_name"]}",
                                  ),
                                  subtitle: Text(
                                    _formatDate(orderData["order_date"]),
                                  ),
                                  trailing: Column(
                                    children: [
                                      orderData["payment"]
                                          ? Text(
                                              "Paid",
                                              style:
                                                  TextStyles().style(500, 10),
                                            )
                                          : Text(
                                              "Not Paid",
                                              style:
                                                  TextStyles().style(500, 10),
                                            ),
                                      orderData["isDone"]
                                          ? const Icon(Icons.task_alt)
                                          : const Icon(Icons.radio_button_off),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return const Card(
                                child: ListTile(
                                  title: Text("No data available"),
                                ),
                              );
                            }
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                MyElevatedButton(
                  borderRadius: BorderRadius.circular(15),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentView(cost: cost),
                      ),
                    );
                  },
                  child: Text(
                    "Pay",
                    style: TextStyle(
                      color: isDarkMode ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Color stringToColor(String colorString) {
    final hexPattern = RegExp(r'Color\(0xff([0-9a-fA-F]+)\)');
    final match = hexPattern.firstMatch(colorString);

    if (match != null) {
      final hexValue = match.group(1);
      if (hexValue != null) {
        return Color(int.parse('0xff$hexValue'));
      }
    }

    return Colors.black;
  }

  String _formatDate(String date) {
    final DateTime dateType = DateTime.parse(date);
    final DateFormat format = DateFormat("dd-MMMM-yyyy, hh:mm");
    return format.format(dateType);
  }
}
