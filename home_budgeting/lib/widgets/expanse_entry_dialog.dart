import 'package:flutter/material.dart';
import 'package:home_budgeting/models/expanse.dart';

Future<Expanse?> showExpanseEnryDialog(
  BuildContext context, {
  String payee = "",
  String description = "",
  int? price,
  String? date,
  String? title
}) {
  return showDialog<Expanse?>(
    context: context,
    builder: (context) {
      final TextEditingController priceController = TextEditingController();
      final TextEditingController payeeController = TextEditingController();
      final TextEditingController descriptionController =
          TextEditingController();
      GlobalKey key = GlobalKey<FormState>();

      priceController.text =price?.toString()??"";
      payeeController.text = payee;
      descriptionController.text = description;
      return AlertDialog(
        title: Text(title??"Add expense"),
        content: Form(
          key: key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: payeeController,
                decoration: InputDecoration(labelText: "Payee"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a payee';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              TextFormField(
                maxLines: 2,
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop(null);
            },
          ),
          TextButton(
            onPressed: () {
              final newDate = date??DateTime.now().toIso8601String();
              Navigator.of(context).pop(
                Expanse(
                  payee: payeeController.text,
                  description: descriptionController.text,
                  price: int.parse(priceController.text),
                  date: newDate,
                ),
              );
            },
            child: Text("Submit"),
          ),
        ],
      );
    },
  );
}
