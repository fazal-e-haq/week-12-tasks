import 'package:flutter/material.dart';
import 'package:order_management_app/Presentation/Widgets/order_tile_widget.dart';
import 'package:order_management_app/Providers/order_provider.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => context.read<OrderProvider>().fetchOrders());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      body: SafeArea(
        child: Padding(
          padding: .all(16),
          child: RefreshIndicator(
            onRefresh: provider.fetchOrders,
            child: provider.loading
                ? Center(child: CircularProgressIndicator())
                : provider.orders.isEmpty
                ? Center(child: Text('No order found'))
                : ListView.builder(
                    itemCount: provider.orders.length,
                    itemBuilder: (context, index) => OrderTileWidget(
                      order: context.watch<OrderProvider>().orders[index],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
