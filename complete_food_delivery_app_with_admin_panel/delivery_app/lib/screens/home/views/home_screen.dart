import 'package:delivery_app/app.dart';
import 'package:delivery_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:delivery_app/screens/home/views/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Row(
          children: [
            Image.asset(
              "8.png",
              scale: 14,
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "Pizza App",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.shopping_cart_outlined)),
          IconButton(
              onPressed: () {
                context.read<SignInBloc>().add(SignOutRequired());
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizantal:16.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 9 / 16),
            itemCount: 10,
            itemBuilder: (context, int index) => Material(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const DetailsScreen()));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("1.png"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30)),
                                color: Colors.red.withOpacity(0.3)),
                            child: const Text(
                              "NON-VEG",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30)),
                                color: Colors.green.withOpacity(0.3)),
                            child: const Text(
                              "🌶 BALANCE",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "Cheezy Marvel",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "Best Taste, Extra Cheeze, Cheap Price, Buy Now",
                        style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: 10,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          
                          children: [
                            Text(
                              "\$12.00",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.primary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                             const Text(
                              "\$15.00",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.add, color: Colors.white,),
                                color: Colors.black,
                                style: ButtonStyle(
                                  fixedSize: const WidgetStatePropertyAll<Size>(Size(20, 20)),
                                  backgroundColor: const WidgetStatePropertyAll<Color>(Colors.black),
                                  shape: WidgetStatePropertyAll<OutlinedBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                ))
                          ],
                        ))
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
