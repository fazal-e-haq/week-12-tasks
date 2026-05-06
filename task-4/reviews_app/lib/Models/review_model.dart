import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final double rating;
  final String comments;
  final int helpful;
  Timestamp time;

  ReviewModel({
    required this.rating,
    required this.comments,
    this.helpful = 0,
    Timestamp? time,
  }) : time = time ?? Timestamp.now();

  Map<String, dynamic> toMap() {
    return {
      'rating': rating,
      'comment': comments,
      'helpful': helpful,
      'time': time,
    };
  }
}
