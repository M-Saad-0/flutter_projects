import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MacroExpanded extends StatelessWidget {
  final String title;
  final IconData icon;
  final int value;
  const MacroExpanded({super.key, required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 5,
                                    color: Colors.grey)
                              ]),
                          child:  Column(
                            children: [
                              FaIcon(icon, color: Colors.red,),
                              Text(title=="Calories"?"$value $title":"${value}g $title", style: const TextStyle(fontSize: 10),)
                            ],
                          ),
                        ),
                      );
  }
}