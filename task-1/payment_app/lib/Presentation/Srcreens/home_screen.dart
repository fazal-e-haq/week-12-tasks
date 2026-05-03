import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_app/Presentation/Srcreens/history_screen.dart';
import 'package:payment_app/Services/payment_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> makePayment() async {
    try {
      final clientSecret = await PaymentService().createPaymentIntent(200);

      if (clientSecret.isEmpty) {
        throw Exception('Empty');
      }
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: clientSecret,
              style: .dark,
              customFlow: false,
              merchantDisplayName: 'Fazal',
            ),
          )
          .then((onValue) {
            displayPaymentSheet(context);
          });
      await saveTransation();
    } catch (e) {
      if (kDebugMode) {
        print('Error : $e');
      }
    }
  }

  void displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance
          .presentPaymentSheet()
          .then((onValue) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Paid Successfully')));
          })
          .onError((error, stackTrace) => throw Exception(error));
    } on StripeException catch (e) {
      if (kDebugMode) {
        print('Error : $e');
      }
    }
  }

  Future<void> saveTransation() async {
    await FirebaseFirestore.instance.collection('PaymentHistory').add({
      'amount': 200,
      'status': 'success',
      'time': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryScreen()),
              );
            },
            icon: Icon(Icons.history),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ElevatedButton(onPressed: makePayment, child: Text('P  a  y')),
        ),
      ),
    );
  }
}
