import 'package:flutter/material.dart';
import 'package:order_management_app/Presentation/Screens/order_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:order_management_app/Providers/order_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: .dark(),
        themeMode: .dark,
        home: OrderScreen(),
      ),
    );
  }
}
