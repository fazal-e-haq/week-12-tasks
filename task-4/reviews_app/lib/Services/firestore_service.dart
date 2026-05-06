import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reviews_app/Models/review_model.dart';

class FirestoreService {
  final String productId = 'product_1';

  CollectionReference get reviews => FirebaseFirestore.instance
      .collection('products')
      .doc(productId)
      .collection('reviews');

  Future<void> addReview(ReviewModel review) async {
    await reviews.add(review.toMap());
  }

  Future<double> getAvarage() async {
    var data = await reviews.get();
    if (data.docs.isEmpty) return 0;
    double total = 0;
    for (var doc in data.docs) {
      total += doc['rating'];
    }
    return total / data.docs.length;
  }

  void increaseHelpful(String id, int current) {
    reviews.doc(id).update({'helpful': current + 1});
  }

  Query getSortedReview(String sort) {
    if (sort == 'helpful') {
      return reviews.orderBy('helpful', descending: true);
    } else if (sort == 'high') {
      return reviews.orderBy('rating', descending: true);
    } else if (sort == 'low') {
      return reviews.orderBy('rating', descending: false);
    } else {
      return reviews.orderBy('time', descending: true);
    }
  }
}
