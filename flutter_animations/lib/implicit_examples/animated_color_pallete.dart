import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedColorPalette extends StatefulWidget {
  const AnimatedColorPalette({super.key});

  @override
  State<AnimatedColorPalette> createState() => _AnimatedColorPaletteState();
}

class _AnimatedColorPaletteState extends State<AnimatedColorPalette> {
  List<Color> currentPalette = generateRandomPalette();
  bool hasRadius = false;

  // @override
  // initState(){
  //   hasRadius = false;
  //   super.initState();
  // }
  static List<Color> generateRandomPalette() {
    final random = Random();
    return List.generate(
      5,
      (_) => Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      ),
    );
  }

  void regeneratePalette() {
    hasRadius = !hasRadius;
    setState(() {
      currentPalette = generateRandomPalette();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Palette Generator'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (Color color in currentPalette)
                AnimatedContainer(
                  curve: Curves.easeInOutCubic,
                  duration: const Duration(seconds: 1),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(hasRadius ? 0 : 50)),
                  margin: const EdgeInsets.all(8),
                ),
              ElevatedButton(
                onPressed: regeneratePalette,
                child: const Text('Generate New Palette'),
              ),
              const SizedBox(
                height: 10,
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                  height: 60,
                  width: !hasRadius? 70:200,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: !hasRadius? const WidgetStatePropertyAll<Color>(Colors.blue):const WidgetStatePropertyAll<Color>(Colors.green)
                  ),
                    onPressed: () {
                      setState(() {
                        hasRadius = !hasRadius;
                      });
                    },
                    child: !hasRadius
                        ? const Center(child:  Icon(Icons.shopping_cart, color: Colors.white))
                        : const Row(
                          mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check, color: Colors.white,),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "Added to cart",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
