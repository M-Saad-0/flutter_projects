import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_budgeting/blocs/expane_bloc/expanse_bloc.dart';
import 'package:home_budgeting/models/expanse.dart';
import 'package:home_budgeting/widgets/expanse_entry_dialog.dart';

class ExpanseWidget extends StatelessWidget {
  final Expanse expanse;
  const ExpanseWidget({super.key, required this.expanse});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
       
        Card(
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
             
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  runAlignment: WrapAlignment.spaceBetween,
                  children: [
                    Icon(Icons.person, color: Colors.amberAccent),
                    const SizedBox(width: 5),
                    Text(expanse.payee),
                    const SizedBox(width: 15),
                    Icon(Icons.money, color: Colors.blueAccent),
                    const SizedBox(width: 5),
                    Text("${expanse.price} Rs"),
                    const SizedBox(width: 15),
                    Icon(Icons.timer, color: Colors.purpleAccent),
                    const SizedBox(width: 5),
                    Text(expanse.date.split("T")[0]),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.description, color: Colors.deepOrangeAccent),
                    Text(expanse.description),
                  ],
                ),
              ],
            ),
          ),
        ),

         Positioned(

          top: 5,
          right: 5,
          child: PopupMenuButton(
            itemBuilder:
                (_) => <PopupMenuItem>[
                  PopupMenuItem(
                    onTap: () async {
                      Expanse? updatedExpanses = await showExpanseEnryDialog(
                        context,
                        payee: expanse.payee,
                        price: expanse.price,
                        description: expanse.description,
                        title: "Update expense",
                        date: expanse.date
                      );
                      if (updatedExpanses != null) {
                        context.read<ExpanseBloc>().add(
                          UpdateExpanse(updatedExpanses),
                        );
                      }
                    },
                    child: Row(
                      children: [Icon(Icons.update),const SizedBox(width: 10,), Text("Update Expense")],
                    ),
                  ),

                  PopupMenuItem(
                    onTap: () async {
                      bool permission =
                          (await showDialog<bool>(
                            context: context,
                            builder:
                                (_) => AlertDialog(
                                  title: Text("Delete Expense"),
                                  content: Text(
                                    "Are you want to delete this expense?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text("Delete"),
                                    ),
                                  ],
                                ),
                          )) ??
                          false;
                      if (permission) {
                        context.read<ExpanseBloc>().add(DeleteExpanse(expanse));
                      }
                    },
                    child: Row(
                      children: [Icon(Icons.delete),const SizedBox(width: 10,), Text("Delete Expense")],
                    ),
                  ),
                ],
          ),
        ),
      ],
    );
  }
}
