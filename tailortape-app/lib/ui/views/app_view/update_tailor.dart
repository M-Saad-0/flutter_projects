import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tailortape/ui/widgets/custom_elevated_button.dart';
import 'package:tailortape/utils/helper_functions.dart';
import 'package:tailortape/utils/thememode_identifier.dart';
import 'package:tailortape/utils/toast_message.dart';

class UpdateDataTailor extends StatefulWidget {
  final String data;
  final String email;
  const UpdateDataTailor({super.key, required this.data, required this.email});

  @override
  State<UpdateDataTailor> createState() => UpdateDataTailorState();
}

class UpdateDataTailorState extends State<UpdateDataTailor> {
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
  @override
  Widget build(BuildContext context) {
    final isDark = ThememodeIdentifier().tell(context);
    List<String> mList = widget.data.split(" ");
    _bicepsController.text = mList[0];
    _chestController.text = mList[1];
    _hipCircumferenceController.text = mList[2];
    _neckController.text = mList[3];
    _paintLengthController.text = mList[4];
    _shirtLengthController.text = mList[5];
    _sleeveLengthController.text = mList[6];
    _troserWaistController.text = mList[7];
    _trouserWidthController.text = mList[8];
    _waistController.text = mList[9];
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Add Measurement")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            HelperFunctions().vSpace(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200,
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
                    width: 200,
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
                    width: 200,
                    child: TextField(
                      controller: _hipCircumferenceController,
                      decoration:
                          const InputDecoration(labelText: 'Hip Circumference'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200,
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
                    width: 200,
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
                    width: 200,
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
                    width: 200,
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
                    width: 200,
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
                    width: 200,
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
                    width: 200,
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
              onPressed: _updateMeasurements,
              child: Text(
                'Save Measurements',
                style: TextStyle(color: !isDark ? Colors.black : Colors.white),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void _updateMeasurements() {
    String data = combineMeasurementData();
    FirebaseFirestore.instance.collection("Customer").doc(widget.email).update(
        {"measurements": data}).onError((e, s) => Message().give(e.toString()));
    Navigator.of(context).pop();
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
}
