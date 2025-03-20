import 'package:flutter/material.dart';
import 'package:perfume_store/provider/order_provider.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: Consumer<OrderProvider>(builder: (context, value, child) {
        if(value.order.isEmpty){
          return const Center(child: Text("No Orders Yet."),);
        }
        return ListView.builder(
            itemCount: value.order.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset("assets/images/${value.order[index].item['image1']}")),
                  title: Text(value.order[index].item['name']),
                  subtitle: Text(value.order[index].item['description']),
                  trailing: IconButton(
                      onPressed: !value.order[index].placed
                          ? () async{
                              await value.deleteOrderItem(value.order[index]);
                            }
                          : () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "This is order is processed and cannot be canceled now.")));
                            },
                      icon: const Icon(Icons.delete)),
                ),
              );
            });
      }),
    );
  }
}
