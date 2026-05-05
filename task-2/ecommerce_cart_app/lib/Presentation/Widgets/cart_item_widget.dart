import 'package:ecommerce_cart_app/Models/product_data.dart';
import 'package:ecommerce_cart_app/Providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key, required this.item});
  final ProductModel item;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context);
    return Card(
      elevation: 5,
      child: ListTile(
        leading: FittedBox(child: item.icon),
        title: Text(item.name.toString()),
        subtitle: Text('Rs ${item.price.toString()}'),
        trailing: SizedBox(
          width: 130,
          child: Row(
            mainAxisAlignment: .end,
            children: [
              IconButton(
                onPressed: () {
                  provider.decrementQuantity(item.id);
                },
                icon: const Icon(Icons.remove),
              ),
              Text(
                item.quantity.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              IconButton(
                onPressed: () {
                  provider.incrementQuantity(item.id);
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
