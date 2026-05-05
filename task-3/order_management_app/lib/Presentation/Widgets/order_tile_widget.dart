import 'package:flutter/material.dart';
import 'package:order_management_app/Models/order_model.dart';
import 'package:order_management_app/Presentation/Screens/order_details_screen.dart';
import 'package:order_management_app/Presentation/Widgets/status_badge_widget.dart';

class OrderTileWidget extends StatelessWidget {
  const OrderTileWidget({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Order : #${order.id}'),
      subtitle: Text('Total : Rs ${order.total}'),
      trailing: StatusBadgeWidget(status: order.status),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(order: order),
          ),
        );
      },
    );
  }
}
