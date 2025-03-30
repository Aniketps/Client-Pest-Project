import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessService {
  late String description;
  late String duration;
  late String idealFor;
  late String name;
  late int rate;
  late String safetyMeasures;
  late String type;

  BusinessService({
    required this.description,
    required this.duration,
    required this.idealFor,
    required this.name,
    required this.rate,
    required this.safetyMeasures,
    required this.type,
  });

  // Factory constructor to create a BusinessService instance from Firebase data
  factory BusinessService.fromMap(Map<String, dynamic> data) {
    return BusinessService(
      description: data['description'] ?? '',
      duration: data['duration'] ?? '',
      idealFor: data['idealFor'] ?? '',
      name: data['name'] ?? '',
      rate: data['rate'] ?? 0,
      safetyMeasures: data['safetyMeasures'] ?? '',
      type: data['type'] ?? '',
    );
  }
}

class BusinessServices {
  List<BusinessService> services = [];

  // Method to fetch all services from Firebase
  Future<void> fetchServices() async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection("Services").get();

      services = snapshot.docs.map((doc) {
        return BusinessService.fromMap(doc.data());
      }).toList();

      print("Fetched ${services.length} services!");
    } catch (e) {
      print("Error: $e");
    }
  }

  // Getters to access all services
  List<BusinessService> get allServices => services;
}