import 'package:delivery_app/components/macro_expanded.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza_repository/pizza_repository.dart';

class DetailsScreen extends StatelessWidget {
  final PizzaModels pizza;
  const DetailsScreen({super.key, required this.pizza});

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
              decoration:  BoxDecoration(
                  boxShadow:const  [
                    BoxShadow(
                        offset: Offset(3, 3), color: Colors.grey, blurRadius: 5)
                  ],
                  color: Colors.white,
                  borderRadius:const BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(image: NetworkImage(pizza.picture))),
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
                       Expanded(
                          flex: 2,
                          child: Text(
                            pizza.name,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      Expanded(
                        flex: 1,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(("\$${(pizza.price-(pizza.discount*pizza.price)/100)}"),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                                 Text("\$${pizza.price}.00",
                                    style: const TextStyle(
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
                   Row(
                    children: [
                       const SizedBox(width: 5),
                       MacroExpanded(
                          icon: FontAwesomeIcons.fire,
                          title: "Calories",
                          value: pizza.macros.calories),
                       const SizedBox(width: 5),
                       MacroExpanded(
                          icon: FontAwesomeIcons.dumbbell,
                          title: "Protien",
                          value: pizza.macros.protien),
                       const SizedBox(width: 5),
                       MacroExpanded(
                          icon: FontAwesomeIcons.droplet,
                          title: "Fat",
                          value: pizza.macros.fat),
                       const SizedBox(width: 5),
                       MacroExpanded(
                          icon: FontAwesomeIcons.breadSlice,
                          title: "Carbs",
                          value: pizza.macros.carbs)
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
