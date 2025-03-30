import 'package:cloud_firestore/cloud_firestore.dart';

class RatingAndReview {
  late String comment;
  late String name;
  late String rate;
  late String userUID;
  late Timestamp date;

  RatingAndReview({
    required this.comment,
    required this.name,
    required this.rate,
    required this.userUID,
    required this.date,
  });

  // Factory constructor to create a RatingAndReview instance from Firebase data
  factory RatingAndReview.fromMap(Map<String, dynamic> data) {
    return RatingAndReview(
      comment: data['comment'] ?? '',
      name: data['name'] ?? '',
      rate: data['rate'] ?? '',
      userUID: data['userUID'] ?? '',
      date: data['date'] ?? Timestamp.now(),
    );
  }
}

class RatingAndReviews {
  List<RatingAndReview> reviews = [];

  // Method to fetch all reviews from Firebase
  Future<void> fetchReviews() async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection("RatingAndReviews").get();

      reviews = snapshot.docs.map((doc) {
        return RatingAndReview.fromMap(doc.data());
      }).toList();

      print("Fetched ${reviews.length} reviews!");
    } catch (e) {
      print("Error: $e");
    }
  }

  // Getters to access all reviews
  List<RatingAndReview> get allReviews => reviews;
}