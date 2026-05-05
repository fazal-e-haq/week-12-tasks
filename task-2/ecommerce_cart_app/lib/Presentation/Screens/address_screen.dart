import 'package:ecommerce_cart_app/Presentation/Screens/Payment_screen.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({super.key});
  final addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('A d d r e s s')),
      body: SafeArea(
        child: Padding(
          padding: .all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'Enter address'),
                controller: addressController,
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentScreen()),
                  );
                },
                child: Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
