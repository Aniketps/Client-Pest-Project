import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Enquiry {
  final String id;  // Document ID
  final String name;
  final String email;
  final String localAddress;
  final String mobileNumber;
  final String serviceUID;
  final String status;
  final String date;

  Enquiry({
    required this.id,  // Initialize document ID
    required this.name,
    required this.email,
    required this.localAddress,
    required this.mobileNumber,
    required this.serviceUID,
    required this.status,
    required this.date,
  });

  // Factory constructor to create an Enquiry instance from Firebase data
  factory Enquiry.fromMap(Map<String, dynamic> data, String id) {
    return Enquiry(
      id: id,  // Assign document ID
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      localAddress: data['localAddress'] ?? '',
      mobileNumber: data['mobileNumber'] ?? '',
      serviceUID: data['serviceUID'] ?? '',
      status: data['status'] ?? 'Neutral',
      date: DateFormat('d MMM y').format(
        (data['date'] as Timestamp).toDate(),
      ),
    );
  }
}

class Enquiries {
  static List<Enquiry> enquiries = [];

  // Method to fetch all enquiries from Firebase and sort by date in descending order
  Future<void> fetchEnquiries() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection("Enquiries")
          .orderBy("date", descending: true)
          .get();

      enquiries = snapshot.docs.map((doc) {
        // Pass document ID to the factory constructor
        return Enquiry.fromMap(doc.data(), doc.id);
      }).toList();

      print("Fetched ${enquiries.length} enquiries!");
    } catch (e) {
      print("Error fetching enquiries: $e");
    }
  }

  // Getters to access all enquiries
  List<Enquiry> get allEnquiries => enquiries;
}