import 'package:delivery_app/components/macro_expanded.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).width - 40,
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(3, 3), color: Colors.grey, blurRadius: 5)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(image: AssetImage("1.png"))),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      offset: Offset(3, 3), color: Colors.grey, blurRadius: 5),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                          flex: 2,
                          child: Text(
                            "Extra Cheeze and Spice",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      Expanded(
                        flex: 1,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("\$12",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                                const Text("\$15",
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    )),
                              ],
                            )),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Row(
                    children: [
                      const SizedBox(width: 5),
                      const MacroExpanded(
                          icon: FontAwesomeIcons.fire,
                          title: "Calories",
                          value: 436),
                      const SizedBox(width: 5),
                      const MacroExpanded(
                          icon: FontAwesomeIcons.dumbbell,
                          title: "Protien",
                          value: 436),
                      const SizedBox(width: 5),
                      const MacroExpanded(
                          icon: FontAwesomeIcons.droplet,
                          title: "Fat",
                          value: 436),
                      const SizedBox(width: 5),
                      const MacroExpanded(
                          icon: FontAwesomeIcons.breadSlice,
                          title: "Carbs",
                          value: 436)
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            elevation: 3,
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {},
                        child: const Text(
                          "Buy Now",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
