import 'package:flutter/material.dart';
import 'package:perfume_store/models/order.dart';
import 'package:perfume_store/models/routes.dart';
import 'package:perfume_store/models/user.dart';
import 'package:perfume_store/provider/cart_provider.dart';
import 'package:perfume_store/provider/order_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> item;
  final MyUser? user;

  const ProductDetailPage({
    super.key,
    required this.item,
    required this.user,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  PageController pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item['name']),
        //backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                  itemCount: 2,
                  onPageChanged: (v) {
                    setState(() {
                      currentIndex = v;
                    });
                  },
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/${widget.item['image${currentIndex + 1}']}",
                        width: 250,
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        if (currentIndex == 0) {
                          currentIndex = 1;
                        } else {
                          currentIndex = 0;
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 500,
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex == 0
                              ? Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.3)
                              : Theme.of(context).colorScheme.onSurface),
                      height: currentIndex == 0 ? 15 : 10,
                      width: currentIndex == 0 ? 15 : 10,
                    )),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        if (currentIndex == 0) {
                          currentIndex = 1;
                        } else {
                          currentIndex = 0;
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 500,
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex == 1
                              ? Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.3)
                              : Theme.of(context).colorScheme.onSurface),
                      height: currentIndex == 1 ? 15 : 10,
                      width: currentIndex == 1 ? 15 : 10,
                    ))
              ],
            ),
            const SizedBox(height: 20),
            Text(
              widget.item['name'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.item['description'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w200,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Rs. ${widget.item['price']}",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (widget.user == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please Login first.")));
                      Navigator.pushNamed(context, Routes.welcomePage);
                    } else {
                      bool confirm = (await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm Order"),
                                content: const Text(
                                    "Are you sure you want to place this order?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text("Confirm"),
                                  ),
                                ],
                              );
                            },
                          ) ??
                          false);

                      if (confirm) {
                        await Provider.of<OrderProvider>(context, listen: false)
                            .addOrderItem(MyOrder(
                                item: widget.item,
                                orderDate: DateTime.now(),
                                user: widget.user!));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Order placed successfully.")),
                        );
                        Navigator.pushNamed(context, Routes.homePage);
                      } else {
                        //do nothing
                      }
                    }
                  },
                  child: const Text("Order Now"),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    if (widget.user == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please Login first.")));
                      Navigator.pushNamed(context, Routes.welcomePage);
                    } else {
                      Provider.of<CartProvider>(context, listen: false)
                          .addCartItem(MyOrder(
                              item: widget.item,
                              orderDate: DateTime.now(),
                              user: widget.user!));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Product added to cart")),
                      );
                      Navigator.pushNamed(context, Routes.homePage);
                    }
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
