import 'package:flutter/material.dart';

class ShoppingCartButton extends StatefulWidget {
  const ShoppingCartButton({super.key});

  @override
  State<ShoppingCartButton> createState() => _ShoppingCartButtonState();
}

class _ShoppingCartButtonState extends State<ShoppingCartButton> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: (){setState(() {
            isClicked = !isClicked;
          });},
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            width: isClicked? 200: 80.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: isClicked? Colors.green:Colors.blue,
              borderRadius: BorderRadius.circular(isClicked?30 : 10.0),
            ),
            child:!isClicked? const Center(child:  Icon(Icons.shopping_cart, color: Colors.white))
                        : const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check, color: Colors.white,),
                             
                              Text(
                                "Added to cart",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
          ),
        ),
      ),
    );
  }
}
