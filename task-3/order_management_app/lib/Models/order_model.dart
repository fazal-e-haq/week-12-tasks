enum OrderStatus { pending, processing, shipped, delivered, canceled }

class OrderModel {
  final String id;
  final List<String> items;
  final double total;
  final String address;
  final OrderStatus status;

  OrderModel({
    required this.id,
    required this.items,
    required this.total,
    required this.address,
    required this.status,
  });

  factory OrderModel.fromMap(String id, Map<String, dynamic> data) {
    return OrderModel(
      id: id,
      items: List<String>.from(data['items']),
      total: (data['total'] as num).toDouble(),
      address: data['address'],
      status: OrderStatus.values.firstWhere(
        (element) => element.name == data['status'],
      ),
    );
  }
}
