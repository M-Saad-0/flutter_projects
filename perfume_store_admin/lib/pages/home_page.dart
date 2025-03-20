import 'package:flutter/material.dart';
import 'package:perfume_store_admin/provider/order_provider.dart';
import 'package:perfume_store_admin/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        // backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.all(4),
          child: Image.asset(
            "assets/images/logo.jpg",
            height: 30,
          ),
        ),
        title: const Text("Prime Fragrance"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'history');
              },
              child: const Text("Order History")),
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
            icon: Provider.of<ThemeProvider>(context).isDark
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<OrderProvider>(builder: (context, value, child) {
          if(value.isLoading){return const Center(child: CircularProgressIndicator(),);}
          final myunCompletedOrder =
              value.order.where((e) => (!e.placed)).toList();
          switch (myunCompletedOrder.isEmpty) {
            case true:
              return const Center(
                child: Text("No order found"),
              );
            case false:
              return ListView.builder(
                  itemCount: myunCompletedOrder.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    "assets/images/${myunCompletedOrder[index].item['image1']}",
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                     Text(
                                      "${myunCompletedOrder[index].item['name']}   (RS ${myunCompletedOrder[index].item['price']})",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Ordered by: ${myunCompletedOrder[index].user.name}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Address: ${myunCompletedOrder[index].user.address}",
                                      style: TextStyle(
                                          color: Colors.grey.shade700),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Date: ${myunCompletedOrder[index].orderDate}",
                                      style: TextStyle(
                                          color: Colors.grey.shade700),
                                    ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  tooltip: "Send Email",
                                  onPressed: () async {
                                    final Uri emailLaunchUri = Uri(
                                      scheme: 'mailto',
                                      path:
                                          myunCompletedOrder[index].user.email,
                                      query:
                                          'subject=Order%20Details&body=Your%20order%20details%20here',
                                    );
                                    await launchUrl(emailLaunchUri);
                                  },
                                  icon: const Icon(Icons.email),
                                ),
                                IconButton(
                                  tooltip: "Complete this order",
                                  onPressed: () async {
                                    await value
                                        .placeOrder(myunCompletedOrder[index]);
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Order is completed!")));

                                  },
                                  icon: const Icon(Icons.check,
                                      color: Colors.green),
                                ),
                                IconButton(
                                  tooltip: "Delete this order",
                                  onPressed: () async {
                                    await value.deleteOrderItem(
                                        myunCompletedOrder[index]);
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Order is deleted!")));

                                  },
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
          }
        }),
      ),
    );
  }
}
