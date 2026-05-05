import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_management_app/Models/order_model.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;

  Future<List<OrderModel>> fetchOrder() async {
    final snapshot = await db
        .collection('orders')

        .get();

    return snapshot.docs
        .map((e) => OrderModel.fromMap(e.id, e.data()))
        .toList();
  }

  Future<void> cencelOrder(String orderId) async {
    await db.collection('orders').doc(orderId).update({'status': 'cancelled'});
  }
}
