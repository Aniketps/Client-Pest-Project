import 'package:cloud_firestore/cloud_firestore.dart';

class AboutBusiness {
  late String _about = '';
  late String _contactNumber = '';
  late String _email = '';
  late String _fullAddress = '';
  late String _businessname = '';
  late String _registeredYear = '';
  late String _schedule = '';
  late String _shortAddress = '';

  // Getters to access the data
  String get about => _about;
  String get contactNumber => _contactNumber;
  String get email => _email;
  String get fullAddress => _fullAddress;
  String get businessname => _businessname;
  String get registeredYear => _registeredYear;
  String get schedule => _schedule;
  String get shortAddress => _shortAddress;

  // Method to fetch data from Firebase
  Future<void> fetchDataFromFirebase() async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection("About Business").get();

      if (snapshot.docs.isNotEmpty) {
        var data = snapshot.docs.first.data();

        _about = data['about'] ?? '';
        _contactNumber = data['contactNumber'] ?? '';
        _email = data['email'] ?? '';
        _fullAddress = data['fullAddress'] ?? '';
        _businessname = data['name'] ?? '';
        _registeredYear = data['registeredYear'] ?? '';
        _schedule = data['schedule'] ?? '';
        _shortAddress = data['shortAddress'] ?? '';

        print("Data fetched successfully!");
      } else {
        print("No data found.");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}