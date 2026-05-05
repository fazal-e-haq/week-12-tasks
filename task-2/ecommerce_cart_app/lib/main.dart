import 'package:ecommerce_cart_app/Presentation/Screens/home_screen.dart';
import 'package:ecommerce_cart_app/Providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51TS5cFGRKfP1slckDRjShjIgqmf3z35oC1N8KadJOauoSSeA9br9clGC9eyHIIvPHFhfVeMfO8rzBDmQ4eb0xJB200edjLJV2g';
  await Stripe.instance.applySettings();

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: .dark(),
        themeMode: .dark,
        home: HomeScreen(),
      ),
    );
  }
}
