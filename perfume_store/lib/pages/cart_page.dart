import 'package:flutter/material.dart';
import 'package:perfume_store/models/order.dart';
import 'package:perfume_store/models/routes.dart';
import 'package:perfume_store/provider/cart_provider.dart';
import 'package:perfume_store/provider/order_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Consumer<CartProvider>(builder: (context, value, child) {
        switch (value.cart.isEmpty) {
          case true:
            return const Center(
              child: Text("No products in cart."),
            );
          case false:
            switch (value.isLoading) {
              case true:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case false:
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: value.cart.length,
                            itemBuilder: (context, index) => Card(
                                  child: ListTile(
                                    leading: Image.asset(
                                      "assets/images/${value.cart[index].item['image1']}",
                                      height: 50,
                                    ),
                                    title: Text(value.cart[index].item['name']),
                                    subtitle: Text(
                                        "${value.cart[index].item['price']} RS"),
                                    trailing: Row(mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextButton(
                                          child: const Text("Buy"),
                                          onPressed: () async {
                                            bool confirm = (await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      "Confirm Order"),
                                                  content: const Text(
                                                      "Are you sure you want to place this order?"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(false);
                                                      },
                                                      child:
                                                          const Text("Cancel"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(true);
                                                      },
                                                      child:
                                                          const Text("Confirm"),
                                                    ),
                                                  ],
                                                );
                                              },
                                            )??false);

                                            if (confirm) {
                                              await Provider.of<OrderProvider>(
                                                      context,
                                                      listen: false)
                                                  .addOrderItem(value.cart[index]);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        "Order placed successfully.")),
                                              );
                                              Navigator.pushNamed(
                                                  context, Routes.homePage);
                                            } else {
                                              //do nothing
                                            }
                                          },
                                        ),
                                        IconButton(
                                          tooltip: "Delete from cart",
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            value.deleteCartItem(
                                                value.cart[index]);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                      ),
                      ListTile(
                        trailing: Text(
                          "${(value.cart.map((e) => e.item['price']).toList()).listSum()} RS",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                );
            }
        }
      }),
    );
  }
}

extension SumPrice on List<dynamic> {
  int listSum() {
    int sum = 0;
    for (int i in this) {
      sum += i;
    }
    return sum;
  }
}
