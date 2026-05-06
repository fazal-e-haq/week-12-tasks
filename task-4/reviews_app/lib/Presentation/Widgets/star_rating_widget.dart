import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  const StarRatingWidget({
    super.key,
    required this.rating,
    required this.onTap,
  });

  final double rating;
  final Function(double) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () {
            onTap(index + 1);
          },
          icon: Icon(index < rating ? Icons.star : Icons.star_border),
          color: Colors.amber,
          iconSize: 50,
        );
      }),
    );
  }
}
