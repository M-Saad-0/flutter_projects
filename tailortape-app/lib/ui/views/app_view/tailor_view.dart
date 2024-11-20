import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tailortape/provider/isdone_provider.dart';
import 'package:tailortape/ui/views/app_view/update_tailor.dart';
import 'package:tailortape/ui/views/settings/setting_view.dart';
import 'package:tailortape/ui/widgets/custom_elevated_button.dart';
import 'package:tailortape/utils/constants/test_styles.dart';
import 'package:tailortape/utils/thememode_identifier.dart';
import 'package:tailortape/utils/toast_message.dart';
import 'package:uuid/uuid.dart';

class TailorView extends StatefulWidget {
  const TailorView({super.key});

  @override
  State<TailorView> createState() => _TailorViewState();
}

class _TailorViewState extends State<TailorView> {
  final snapshot =
      FirebaseFirestore.instance.collection("Customer").snapshots();
  final User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController _priceController = TextEditingController();
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ThememodeIdentifier().tell(context);
    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset(
          "assets/icons/app_logo.svg",
          colorFilter: ColorFilter.mode(
              !isDarkMode ? const Color(0xff000000) : const Color(0xffffffff),
              BlendMode.srcIn),
        ),
        title: const Text("Your Customers"),
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
                                  builder: (context) => const SettingView()));
                        },
                        leading: const Icon(Icons.settings),
                      ),
                    )),
                    PopupMenuItem(
                        child: Card(
                      child: ListTile(
                        title: const Text("Set price"),
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text("Set you price"),
                                    content: TextField(
                                      controller: _priceController,
                                      decoration: const InputDecoration(
                                          labelText: 'Price in PKR'),
                                      keyboardType: TextInputType.number,
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection("Tailor")
                                                .doc(user!.uid)
                                                .set({
                                              "cost": int.parse(_priceController
                                                  .text
                                                  .toString())
                                            }, SetOptions(merge: true));
                                            Navigator.of(context).pop();
                                            Message().give(
                                                "Your price is set to ${_priceController.text}");
                                          },
                                          child: const Text("Set"))
                                    ],
                                  ));
                        },
                        leading: const Icon(Icons.settings),
                      ),
                    )),
                    PopupMenuItem(
                        child: Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
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
                                              BlendMode.srcIn),
                                        ),
                                        const Text("Tailortape 1.0.0")
                                      ],
                                    ),
                                    // ignore: sized_box_for_whitespace
                                    content: Container(
                                      height: 150,
                                      child: const Center(
                                        child: Column(
                                          children: [
                                            Text("App Version:  1.0.0"),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Made By",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text("Muhammad Saad 1997"),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text("Muhammad Umar Jan 2000"),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text("Kashif Alam 1979"),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Close"))
                                    ],
                                  ));
                        },
                        title: const Text("About"),
                        leading: const Icon(Icons.info),
                      ),
                    ))
                  ])
        ],
      ),
      body: StreamBuilder(
        stream: snapshot,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  String tailor_id ="";
                  try{tailor_id= snapshot.data!.docs[index]["tailor_id"];}catch (e){tailor_id="";}
                  if (snapshot.data != null && 
                      tailor_id ==
                          FirebaseAuth.instance.currentUser!.uid) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          List<String> measurementNames = [
                            "Biceps",
                            "Chest",
                            "Hip Circumference",
                            "Neck",
                            "Paint Length",
                            "Shirt Length",
                            "Sleeve Length",
                            "Trouser Waist",
                            "Trouser Width",
                            "Waist"
                          ];
                          List<String> measurements = snapshot
                              .data!.docs[index]["measurements"]
                              .split(' ');
                          try {
                            showBottomSheet(
                                context: context,
                                builder: (BuildContext context) => SingleChildScrollView(
                                  child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              "${snapshot.data!.docs[index]["first_name"]} ${snapshot.data!.docs[index]["last_name"]} ",
                                              style: TextStyles().style(500, 25)),
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                const Text(
                                                    "Current Order Status:  "),
                                                Consumer<IsDone>(
                                                  builder: (context, value,
                                                          child) =>
                                                      TextButton(
                                                          onPressed: () async {
                                                            try {
                                                              Query query = FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "Order")
                                                                  .where(
                                                                      "customer_id",
                                                                      isEqualTo: snapshot
                                                                              .data!
                                                                              .docs[index]
                                                                          [
                                                                          "email"])
                                                                  .where(
                                                                      "tailor_id",
                                                                      isEqualTo:
                                                                          user!
                                                                              .uid);
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          AlertDialog(
                                                                            title:
                                                                                const Text("Select which one is completed"),
                                                                            content: StreamBuilder<QuerySnapshot>(
                                                                                stream: query.snapshots(),
                                                                                builder: (context, snapshot) {
                                                                                  if (snapshot.hasData) {
                                                                                    return SizedBox(
                                                                                      height: 300,
                                                                                      width: 300,
                                                                                      child: ListView.builder(
                                                                                          shrinkWrap: true,
                                                                                          itemCount: snapshot.data!.docs.length,
                                                                                          itemBuilder: (context, i) {
                                                                                            if (snapshot.data != null) {
                                                                                              return Card(
                                                                                                child: ListTile(
                                                                                                  onTap: () {
                                                                                                    FirebaseFirestore.instance.collection("Order").doc(snapshot.data!.docs[i]["order_id"]).set({
                                                                                                      "isDone": !value.isDone
                                                                                                    }, SetOptions(merge: true));
                                                                                                    value.setIsDone(!value.isDone);
                                                                                                    Message().give("The user will notified if logged in");
                                                                                                  },
                                                                                                  title: Row(
                                                                                                    children: [
                                                                                                      const Text("Cloth with color:   "),
                                                                                                      Container(
                                                                                                        height: 20,
                                                                                                        width: 20,
                                                                                                        color: stringToColor(snapshot.data!.docs[i]["color"]),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              );
                                                                                            } else {
                                                                                              return const Text(" ");
                                                                                            }
                                                                                          }),
                                                                                    );
                                                                                  } else {
                                                                                    return const Text("No Data");
                                                                                  }
                                                                                }),
                                                                            actions: [
                                                                              TextButton(
                                                                                child: const Text("Ok"),
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                              )
                                                                            ],
                                                                          ));
                                                            } catch (e) {
                                                              debugPrint(
                                                                  'Error fetching order ID: $e');
                                                            }
                                                          },
                                                          child: value.isDone
                                                              ? const Icon(
                                                                  Icons.check_box)
                                                              : const Icon(Icons
                                                                  .check_box_outline_blank)),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Table(
                                              border: TableBorder.all(
                                                  color: isDarkMode
                                                      ? Colors.white
                                                      : Colors.black),
                                              columnWidths: const {
                                                0: FlexColumnWidth(1),
                                                1: FlexColumnWidth(2),
                                              },
                                              children: [
                                                const TableRow(
                                                  children: [
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          'Measurement',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          'Value',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                ...List.generate(
                                                    measurements.length, (i) {
                                                  return TableRow(
                                                    children: [
                                                      TableCell(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              measurementNames[
                                                                  i]),
                                                        ),
                                                      ),
                                                      TableCell(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              measurements[i]),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }),
                                              ],
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            "Pick a color"),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: ColorPicker(
                                                            pickerColor:
                                                                pickerColor,
                                                            onColorChanged:
                                                                (color) {
                                                              currentColor =
                                                                  color;
                                                            },
                                                          ),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                              onPressed:
                                                                  () async {
                                                                String uid =
                                                                    const Uuid()
                                                                        .v4();
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "Customer")
                                                                    .doc(snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                        ["email"])
                                                                    .set(
                                                                        {
                                                                      "no_of_orders":
                                                                          snapshot.data!.docs[index]["no_of_orders"] +
                                                                              1
                                                                    },
                                                                        SetOptions(
                                                                            merge:
                                                                                true));
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "Order")
                                                                    .doc(uid)
                                                                    .set(
                                                                        {
                                                                          "color":
                                                                              currentColor.toString(),
                                                                          "order_id":
                                                                              uid,
                                                                          "tailor_id":
                                                                              user!.uid,
                                                                          "customer_id": snapshot
                                                                              .data!
                                                                              .docs[index]["email"],
                                                                          "isDone":
                                                                              false,
                                                                          "order_date":
                                                                              DateTime.now().toString(),
                                                                          "payment":
                                                                              false
                                                                        },
                                                                        SetOptions(
                                                                            merge:
                                                                                true))
                                                                    .then(
                                                                      (value) =>
                                                                          Message()
                                                                              .give("Successfully made an order."),
                                                                    )
                                                                    .onError(
                                                                      (error, stackTrace) =>
                                                                          Message()
                                                                              .give(error.toString()),
                                                                    );
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                  "Pick"))
                                                        ],
                                                      );
                                                    });
                                              },
                                              child:
                                                  const Text("Make a new order")),
                                          MyElevatedButton(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "Ok",
                                                style: TextStyle(
                                                    color: isDarkMode
                                                        ? Colors.black
                                                        : Colors.white),
                                              ))
                                        ],
                                      ),
                                ));
                          } catch (e) {
                            Message().give(e.toString());
                          }
                        },
                        subtitle: Text(snapshot
                            .data!.docs[index]["measurements"]
                            .toString()),
                        title: Text(
                            "${snapshot.data!.docs[index]["first_name"]} ${snapshot.data!.docs[index]["last_name"]}"),
                        leading: const Icon(Icons.person),
                        trailing: PopupMenuButton(itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              child: const Text("Update"),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateDataTailor(
                                              data: snapshot.data!.docs[index]
                                                  ["measurements"],
                                              email: snapshot.data!.docs[index]
                                                  ["email"],
                                            )));
                              },
                            ),
                            PopupMenuItem(
                              child: const Text("Delete"),
                              onTap: () {
                                FirebaseFirestore.instance
                                    .collection("Customer")
                                    .doc(snapshot.data!.docs[index]["email"])
                                    .delete();
                              },
                            )
                          ];
                        }),
                      ),
                    );
                  } else {
                    return Container();
                  }
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "measurement");
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
}
