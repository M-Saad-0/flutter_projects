import 'package:flutter/material.dart';

class ListAnimation extends StatefulWidget {
  const ListAnimation({super.key});

  @override
  State<ListAnimation> createState() => _ListAnimationState();
}

class _ListAnimationState extends State<ListAnimation> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late List<Animation<Offset>> offsets;
  @override
  initState(){
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    offsets = List.generate(5, (i)=>Tween(begin: const Offset(-1, 0),end: Offset.zero).animate(CurvedAnimation(parent: controller, curve: Interval(i*(1/5), 1))), );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Animation'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return SlideTransition(
            position: offsets[index],
            child: ListTile(
              title: Text('Hello World, Rivaan. ${index.toString()}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(controller.isCompleted){
                controller.reverse();
          }else{
                controller.forward();
          }
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}
