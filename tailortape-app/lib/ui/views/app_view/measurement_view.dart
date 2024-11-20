import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:tailortape/ui/widgets/custom_elevated_button.dart';
import 'package:tailortape/utils/helper_functions.dart';
import 'package:tailortape/utils/thememode_identifier.dart';
import 'package:uuid/uuid.dart';

class MeasurementView extends StatefulWidget {
  const MeasurementView({super.key});

  @override
  State<MeasurementView> createState() => _MeasurementViewState();
}

class _MeasurementViewState extends State<MeasurementView> {
  final TextEditingController _bicepsController = TextEditingController();
  final TextEditingController _chestController = TextEditingController();
  final TextEditingController _hipCircumferenceController =
      TextEditingController();
  final TextEditingController _neckController = TextEditingController();
  final TextEditingController _paintLengthController = TextEditingController();
  final TextEditingController _shirtLengthController = TextEditingController();
  final TextEditingController _sleeveLengthController = TextEditingController();
  final TextEditingController _troserWaistController = TextEditingController();
  final TextEditingController _trouserWidthController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _userEmail = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);
  @override
  Widget build(BuildContext context) {
    final isDark = ThememodeIdentifier().tell(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Add Measurement")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _userName,
                decoration: const InputDecoration(
                  labelText: 'Customer Name',
                ),
                keyboardType: TextInputType.name,
              ),
              HelperFunctions().vSpace(10),
              TextField(
                controller: _userEmail,
                decoration: const InputDecoration(
                  labelText: 'Customer Email',
                ),
                keyboardType: TextInputType.emailAddress,
                autofillHints: const ["@gmail.com", "@outlook.com"],
              ),
              HelperFunctions().vSpace(10),
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Pick a color"),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: pickerColor,
                                onColorChanged: (color) {
                                  currentColor = color;
                                },
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Pick"))
                            ],
                          );
                        });
                  },
                  child: const Text("Color of cloth")),
              HelperFunctions().vSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 140,
                      child: TextField(
                        controller: _bicepsController,
                        decoration: const InputDecoration(labelText: 'Biceps'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 140,
                      child: TextField(
                        controller: _chestController,
                        decoration: const InputDecoration(labelText: 'Chest'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 140,
                      child: TextField(
                        controller: _hipCircumferenceController,
                        decoration: const InputDecoration(
                            labelText: 'Hip Circumference'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 140,
                      child: TextField(
                        controller: _neckController,
                        decoration: const InputDecoration(labelText: 'Neck'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 140,
                      child: TextField(
                        controller: _paintLengthController,
                        decoration:
                            const InputDecoration(labelText: 'Pant Length'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 140,
                      child: TextField(
                        controller: _shirtLengthController,
                        decoration:
                            const InputDecoration(labelText: 'Shirt Length'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 140,
                      child: TextField(
                        controller: _sleeveLengthController,
                        decoration:
                            const InputDecoration(labelText: 'Sleeve Length'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 140,
                      child: TextField(
                        controller: _troserWaistController,
                        decoration:
                            const InputDecoration(labelText: 'Trouser Waist'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 140,
                      child: TextField(
                        controller: _trouserWidthController,
                        decoration:
                            const InputDecoration(labelText: 'Trouser Width'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 140,
                      child: TextField(
                        controller: _waistController,
                        decoration: const InputDecoration(labelText: 'Waist'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ],
              ),
              HelperFunctions().vSpace(40),
              MyElevatedButton(
                borderRadius: BorderRadius.circular(15),
                onPressed: _saveMeasurements,
                child: Text(
                  'Save Measurements',
                  style:
                      TextStyle(color: !isDark ? Colors.black : Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveMeasurements() async {
    List<String> names = _userName.text.toString().split(" ");
    bool hasOrNot = await hasNameFields();
    String data = combineMeasurementData();
    final User user = FirebaseAuth.instance.currentUser!;
    if (_userEmail.text.contains("@") && !hasOrNot) {
      FirebaseFirestore.instance
          .collection("Customer")
          .doc(_userEmail.text)
          .set({
        "email": _userEmail.text,
        "measurements": data,
        "tailor_id": user.uid,
        "first_name": names[0],
        "last_name": names[1],
        "no_of_orders": 1
      });
      String uid = const Uuid().v4();
      FirebaseFirestore.instance.collection("Order").doc(uid).set({
        "color": currentColor.toString(),
        "order_id": uid,
        "tailor_id": user.uid,
        "customer_id": _userEmail.text,
        "order_date": DateTime.now().toString(),
        "payment": false,
        "isDone": false
      }, SetOptions(merge: true));
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } else if (_userEmail.text.contains("@") && hasOrNot) {
      FirebaseFirestore.instance
          .collection("Customer")
          .doc(_userEmail.text)
          .set({
        "email": _userEmail.text,
        "measurements": data,
        "tailor_id": user.uid,
        "no_of_orders": 1
      }, SetOptions(merge: true));
      String uid = const Uuid().v4();
      FirebaseFirestore.instance.collection("Order").doc(uid).set({
        "color": currentColor.toString(),
        "order_id": uid,
        "tailor_id": user.uid,
        "customer_id": _userEmail.text,
        "order_date": DateTime.now().toString(),
        "payment": false,
        "isDone": false
      }, SetOptions(merge: true));
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } else if (!_userEmail.text.contains("@") && !hasOrNot) {
      FirebaseFirestore.instance
          .collection("Customer")
          .doc(_userEmail.text)
          .set({
        "email": _userEmail.text,
        "measurements": data,
        "tailor_id": user.uid,
        "first_name": names[0],
        "last_name": names[1],
        "no_of_orders": 1
      });
      String uid = const Uuid().v4();
      FirebaseFirestore.instance.collection("Order").doc(uid).set({
        "color": currentColor.toString(),
        "order_id": uid,
        "tailor_id": user.uid,
        "customer_id": _userEmail.text,
        "order_date": DateTime.now().toString(),
        "payment": false,
        "isDone": false
      }, SetOptions(merge: true));
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } else {
      FirebaseFirestore.instance
          .collection("Customer")
          .doc("${_userEmail.text}@gmail.com")
          .set({
        "email": "${_userEmail.text}@gmail.com",
        "measurements": data,
        "tailor_id": user.uid,
        "no_of_orders": 1
      }, SetOptions(merge: true));
      String uid = const Uuid().v4();
      FirebaseFirestore.instance.collection("Order").doc(uid).set({
        "color": currentColor.toString(),
        "order_id": uid,
        "tailor_id": user.uid,
        "customer_id": _userEmail.text,
        "order_date": DateTime.now().toString(),
        "payment": false,
        "isDone": false
      }, SetOptions(merge: true));

      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  String combineMeasurementData() {
    return [
      _bicepsController.text,
      _chestController.text,
      _hipCircumferenceController.text,
      _neckController.text,
      _paintLengthController.text,
      _shirtLengthController.text,
      _sleeveLengthController.text,
      _troserWaistController.text,
      _trouserWidthController.text,
      _waistController.text,
    ].join(' ');
  }

  Future<bool> hasNameFields() async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('yourCollectionName')
          .doc(_userEmail.text);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        return docSnapshot.data()!.containsKey('first_name') &&
            docSnapshot.data()!.containsKey('last_name');
      } else {
        debugPrint('Document does not exist');
        return false;
      }
    } catch (e) {
      debugPrint('Error checking document: $e');
      return false;
    }
  }
}
