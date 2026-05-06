import 'package:flutter/material.dart';
import 'package:reviews_app/Models/review_model.dart';
import 'package:reviews_app/Presentation/Widgets/star_rating_widget.dart';
import 'package:reviews_app/Services/firestore_service.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final service = FirestoreService();
  final controller = TextEditingController();
  double rating = 0;
  String sort = 'recent';

  @override
  Widget build(BuildContext context) {
    var query = service.getSortedReview(sort);

    return Scaffold(
      appBar: AppBar(title: Text('Review')),
      body: SafeArea(
        child: Padding(
          padding: .symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: .center,crossAxisAlignment: .center,
            children: [
              FutureBuilder<double>(
                future: service.getAvarage(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  
                  return Text('Average : ${snapshot.data!.toStringAsFixed(1)}');
                },
              ),
             
               Align(
                 alignment: .topRight,
                 child: DropdownButton(
                    value: sort,
                    items: [
                      DropdownMenuItem(value: 'recent', child: Text('Recent')),
                      DropdownMenuItem(value: 'helpful', child: Text('Helpful')),
                      DropdownMenuItem(value: 'rating', child: Text('High rating')),
                      DropdownMenuItem(value: 'rating', child: Text('Low rating')),
                    ],
                    onChanged: (value) {
                      setState(() => sort = value.toString());
                    },
                  ),
               ),
              


                StarRatingWidget(
                  rating: rating,
                  onTap: (value) {
                    setState(() => rating = value);
                  },
                ),
              SizedBox(height: 30,),
              TextField(
                minLines: 5,
                maxLines: 5,
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write review',
                ),
              ),
              SizedBox(height: 50,),
              SizedBox(
                width: .infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (rating == 0 || controller.text.isEmpty) return;
                    ReviewModel review = ReviewModel(
                      rating: rating,
                      comments: controller.text,
                    );
                    await service.addReview(review);
                    controller.clear();
                    setState(() => rating = 0);
                  },
                  child: Text('Submit'),
                ),
              ),
              SizedBox(height: 30,),
              Expanded(
                child: StreamBuilder(
                  stream: query.snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    var docs = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        var r = docs[index];
                        return ListTile(
                          title: Text(r['comment']),
                          subtitle: Text('Rating : ${r['rating']}'),
                          trailing: Row(
                            mainAxisSize: .min,
                            children: [
                              Text('${r['helpful']}'),
                              IconButton(
                                onPressed: () {
                                  service.increaseHelpful(r.id, r['helpful']);
                                },
                                icon: Icon(Icons.thumb_up),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
