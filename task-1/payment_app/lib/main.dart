import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_app/Presentation/Srcreens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51TS5cFGRKfP1slckDRjShjIgqmf3z35oC1N8KadJOauoSSeA9br9clGC9eyHIIvPHFhfVeMfO8rzBDmQ4eb0xJB200edjLJV2g";
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Stripe.instance.applySettings();


  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: .dark(),
      themeMode: .dark,
      home: HomeScreen(),
    );
  }
}
