import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class RatingAndReview {
  late String comment;
  late String name;
  late int rate;
  late String userUID;
  late String date;

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
      date: DateFormat('d MMM y').format(
        (data['date'] as Timestamp).toDate(),
      ),
      rate: int.tryParse(data['rate'].toString()) ?? 0,  // Cast rate to int
      userUID: data['userUID'] ?? '',
    );
  }
}

class RatingAndReviews {
  List<RatingAndReview> reviews = [];

  // Method to fetch all reviews from Firebase and sort by date in descending order
  Future<void> fetchReviews() async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection("Reviews And Ratings").get();

      reviews = snapshot.docs.map((doc) {
        return RatingAndReview.fromMap(doc.data());
      }).toList();

      // Sort reviews by date in descending order
      reviews.sort((a, b) {
        // Convert the date strings back to DateTime for proper comparison
        DateTime dateA = DateFormat('d MMM y').parse(a.date);
        DateTime dateB = DateFormat('d MMM y').parse(b.date);
        return dateB.compareTo(dateA); // For descending order
      });

      print("Fetched ${reviews.length} reviews!");
    } catch (e) {
      print("Error: $e");
    }
  }

  // Getters to access all reviews
  List<RatingAndReview> get allReviews => reviews;
}
