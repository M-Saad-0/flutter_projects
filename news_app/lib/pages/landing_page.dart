import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    "assets/images/building_1.png",
                    height: MediaQuery.sizeOf(context).height / 1.7,
                    fit: BoxFit.cover,
                    width: MediaQuery.sizeOf(context).width,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          text: "News from around the\n",
                          children: [
                            TextSpan(text: " world for you\n"),
                            TextSpan(
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                                text:
                                    "\nBest time to read and know about the world")
                          ])),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            SizedBox(
              height: 70,
              width: 200,
              child: ElevatedButton(
                  style: const ButtonStyle(
                    elevation: WidgetStatePropertyAll(10),
                    backgroundColor:
                        WidgetStatePropertyAll<Color>(Colors.black),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
            ),
            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
