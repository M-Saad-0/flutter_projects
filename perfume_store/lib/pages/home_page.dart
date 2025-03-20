import 'package:flutter/material.dart';
import 'package:perfume_store/models/order.dart';
import 'package:perfume_store/models/perfume.dart';
import 'package:perfume_store/models/routes.dart';
import 'package:perfume_store/models/user.dart';
import 'package:perfume_store/provider/theme_provider.dart';
import 'package:perfume_store/provider/user_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    MyUser? user = Provider.of<MyUserProvider>(context, listen: false).user;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        //backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.all(4),
          child: Image.asset(
            "assets/images/logo.jpg",
            height: 30,
          ),
        ),
        title: const Text("Prime Fragrance"),
        actions: [
          user == null
              ? TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.welcomePage);
                  },
                  child: const Text("Login"),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.cart);
                      },
                      child: const Text("Cart"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.order);
                      },
                      child: const Text("Orders"),
                    ),
                  ],
                ),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Hero Section (ListWheelScrollView)
              Container(
                alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  height: 400,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      gradient: LinearGradient(colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/hero_image.png',
                        height: 200,
                      ),
                      const Text(
                        textAlign: TextAlign.center,
                        "Buy all the best perfumes here",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      )
                    ],
                  )),

              const SizedBox(height: 20),

              // Perfume Grid
              SizedBox(
                height:null,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: perfumes.length,
                  itemBuilder: (context, index) {
                    final perfume = perfumes[index];

                    return GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, Routes.product, arguments: {'item':perfume,'user':user });
                      },
                      child: Card(
                        
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12)),
                                child: Image.asset(
                                  "assets/images/${perfume['image1']}",
                                  width: double.infinity,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              perfume['name'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Rs. ${perfume['price']}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
