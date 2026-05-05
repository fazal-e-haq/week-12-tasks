import 'package:ecommerce_cart_app/Providers/cart_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import '../../Services/stripe_service.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String paymentMethod = 'COD';

  Future<void> makePayment(BuildContext con) async {
    int totalamount = context.read<CartProvider>().total.toInt();
    try {
      final clientSecret = await PaymentService().createPaymentIntent(
        totalamount,
      );

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('P a y')),
      body: SafeArea(
        child: Padding(
          padding: .all(16),
          child: Column(
            children: [
              RadioListTile(
                title: Text('Cash on delivery'),
                value: 'COD',
                groupValue: paymentMethod,
                onChanged: (value) => setState(() => paymentMethod = value!),
              ),
              RadioListTile(
                title: Text('Credit Card'),
                value: 'CARD',
                groupValue: paymentMethod,
                onChanged: (value) => setState(() => paymentMethod = value!),
              ),
              SizedBox(height: 500),
              SizedBox(
                width: .infinity,
                child: ElevatedButton(
                  onPressed: () {
                    paymentMethod == 'CARD'
                        ? makePayment(context)
                        : ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Order Place')),
                          );
                    context.read<CartProvider>().clearCart();
                  },
                  child: Text('Confirm order'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
