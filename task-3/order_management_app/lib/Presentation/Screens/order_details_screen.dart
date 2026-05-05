import 'package:flutter/material.dart';
import 'package:order_management_app/Models/order_model.dart';
import 'package:order_management_app/Presentation/Widgets/order_stepper_widget.dart';
import 'package:order_management_app/Providers/order_provider.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('Order Details')),
      body: SafeArea(
        child: Padding(
          padding: .symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text('Items :',style: Theme.of(context).textTheme.headlineSmall,),
              ...order.items.map((e) => Text('- $e')),
              SizedBox(height: 10),
              Text('Total : Rs ${order.total}',style: Theme.of(context).textTheme.bodyLarge),
              Text('Address : ${order.address}',style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(height: 20),
              OrderStepperWidget(status: order.status),
              Spacer(),
              SizedBox(
                width: .infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await provider.canceledOrder(order);
                     await provider.fetchOrders();
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Error -> ${e.toString()}')));
                    }
                  },
                  child: Text('Cancel order'),
                ),
              ),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}
