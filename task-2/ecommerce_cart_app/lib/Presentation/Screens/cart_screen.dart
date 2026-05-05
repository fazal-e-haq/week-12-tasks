 import 'package:ecommerce_cart_app/Presentation/Screens/address_screen.dart';
import 'package:ecommerce_cart_app/Presentation/Widgets/cart_item_widget.dart';
import 'package:ecommerce_cart_app/Providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context);
    print(provider.items.length);
    return Scaffold(
      appBar: AppBar(title: Text('C a r t')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: context
                    .watch<CartProvider>()
                    .items
                    .map((e) => CartItemWidget(item: e))
                    .toList(),
              ),
            ),
            Padding(
              padding: .all(10),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'Subtotal : Rs ${context.watch<CartProvider>().subTotal.toString()}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'Tax : Rs ${context.watch<CartProvider>().tax.toString()}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'Shipping : Rs ${context.watch<CartProvider>().shippingFee.toString()}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'Discount : Rs ${context.watch<CartProvider>().discount.toString()}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Divider(),
                  Divider(),
                  Text(
                    'Total : Rs ${context.watch<CartProvider>().total.toString()}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Divider(),
                  Divider(),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Discount code',
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      context.read<CartProvider>().applyDiscount(value);
                    },
                  ),
                  SizedBox(
                    width: .infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddressScreen(),
                          ),
                        );
                      },
                      child: Text('Checkout'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
