import 'dart:convert';

import 'package:http/http.dart' as http;

class PaymentService {
  Future<String> createPaymentIntent(int amount) async {
    final res = await http.post(
      Uri.parse('http://10.0.2.2:3000/create-payment-intent'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'amount': amount}),
    );
    return jsonDecode(res.body)['clientSecret'];
  }
}
