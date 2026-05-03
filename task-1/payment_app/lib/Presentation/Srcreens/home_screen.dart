import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_app/Services/payment_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void pay() async {
    try {
      final clientSecret = await PaymentService().createPaymentIntent(20);
      await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: clientSecret,
      );
      await saveTransation();
      showDilog(true);
    } catch (e) {
      debugPrint('Error : $e');
    }
  }

  Future<void> saveTransation() async {
    await FirebaseFirestore.instance.collection('collection').add({
      'amount': 20,
      'status': 'success',
      "time": FieldValue.serverTimestamp(),
    });
  }

  void showDilog(bool isPayed) {
    showDialog(
      context: context,
      builder: (context) => Text(isPayed ? 'Paid successfully' : 'Not Paid'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment App'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.history))],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CardFormField(
                style: CardFormStyle(borderRadius: 20),
                onCardChanged: (details) {
                  debugPrint(details?.complete.toString());
                },
              ),

              ElevatedButton(onPressed: pay, child: Text('P  a  y')),
            ],
          ),
        ),
      ),
    );
  }
}
