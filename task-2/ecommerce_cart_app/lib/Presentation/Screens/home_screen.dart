import 'package:ecommerce_cart_app/Data/item_data.dart';
import 'package:ecommerce_cart_app/Models/product_data.dart';
import 'package:ecommerce_cart_app/Presentation/Screens/cart_screen.dart';
import 'package:ecommerce_cart_app/Providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final carts = products;
    final provider = Provider.of<CartProvider>(context,);
    return Scaffold(
      appBar: AppBar(
        title: Text('S h o p p i n g'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: SafeArea(
        child: GridView.builder(
          itemCount: carts.length,
          scrollDirection: .vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,

            mainAxisExtent: 270,
          ),
          itemBuilder: (context, index) {
            final cart = products[index];

            return Container(
              margin: .all(6),
              padding: .all(10),

              decoration: BoxDecoration(
                borderRadius: .circular(20),
                gradient: LinearGradient(
                  colors: [Colors.white12, Colors.white60],
                  begin: .bottomCenter,
                  end: .topCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 5,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                 
                   cart.icon,
                  Text(
                    cart.name.toString(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    cart.price.toString(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CartProvider>().addToCart(
                        ProductModel(
                          id: cart.id,
                          icon: cart.icon,
                          name: cart.name,
                          price: cart.price,
                        ),
                      );
                    },
                    child: Text('Add to cart'),
                  ),
                ],
              ),
            );
            ;
          },
        ),
      ),
    );
  }
}
