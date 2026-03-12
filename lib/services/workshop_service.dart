import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/workshop.dart';

class WorkshopService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  
  Future<void> addWorkshop(Workshop workshop) async {
    await _firestore.collection('workshops').doc(workshop.id).set({
      'id': workshop.id,
      'title': workshop.title,
      'description': workshop.description,
      'fullDescription': workshop.fullDescription,
      'imageUrl': workshop.imageUrl,
      'category': workshop.category,
      'location': workshop.location,
      'address': workshop.address,
      'date': workshop.date,
      'time': workshop.time,
      'rating': workshop.rating,
      'instructor': workshop.instructor,
      'instructorBio': workshop.instructorBio,
      'contactEmail': workshop.contactEmail,
      'price': workshop.price,
      'duration': workshop.duration,
      'level': workshop.level,
      'whatYoullLearn': workshop.whatYoullLearn,
      'schedule': workshop.schedule.map((s) => {
        'title': s.title,
        'activities': s.activities,
      }).toList(),
      'materials': workshop.materials,
      'spotsAvailable': workshop.spotsAvailable,
      'totalSpots': workshop.totalSpots,
    });
  }

  /*one time fetch for all workshops at once then 
converts each document back into a Workshop object and 
handles missing fields with ?? (default values) then
errors are caught and return an empty list. */
  Future<List<Workshop>> getAllWorkshops() async {
    try {
      final snapshot = await _firestore.collection('workshops').get();
      
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Workshop(
          id: data['id'] ?? '',
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          fullDescription: data['fullDescription'] ?? '',
          imageUrl: data['imageUrl'] ?? '',
          category: data['category'] ?? '',
          location: data['location'] ?? '',
          address: data['address'] ?? '',
          date: data['date'] ?? '',
          time: data['time'] ?? '',
          rating: (data['rating'] ?? 0.0).toDouble(),
          instructor: data['instructor'] ?? '',
          instructorBio: data['instructorBio'] ?? '',
          contactEmail: data['contactEmail'] ?? '',
          price: (data['price'] ?? 0.0).toDouble(),
          duration: data['duration'] ?? '',
          level: data['level'] ?? '',
          whatYoullLearn: List<String>.from(data['whatYoullLearn'] ?? []),
          schedule: (data['schedule'] as List?)?.map((s) => 
            WorkshopSchedule(
              title: s['title'] ?? '',
              activities: List<String>.from(s['activities'] ?? []),
            )
          ).toList() ?? [],
          materials: List<String>.from(data['materials'] ?? []),
          spotsAvailable: data['spotsAvailable'] ?? 0,
          totalSpots: data['totalSpots'] ?? 0,
        );
      }).toList();
    } catch (e) {
      print('Error getting workshops: $e');
      return [];
    }
  }

  /*returns a stream which updates automatically when Firestore data changes
 like a workshop list that refreshes in real time and it has similar mapping to Workshop objects.*/
  Stream<List<Workshop>> getWorkshopsStream() {
    return _firestore.collection('workshops').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Workshop(
          id: data['id'] ?? '',
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          fullDescription: data['fullDescription'] ?? '',
          imageUrl: data['imageUrl'] ?? '',
          category: data['category'] ?? '',
          location: data['location'] ?? '',
          address: data['address'] ?? '',
          date: data['date'] ?? '',
          time: data['time'] ?? '',
          rating: (data['rating'] ?? 0.0).toDouble(),
          instructor: data['instructor'] ?? '',
          instructorBio: data['instructorBio'] ?? '',
          contactEmail: data['contactEmail'] ?? '',
          price: (data['price'] ?? 0.0).toDouble(),
          duration: data['duration'] ?? '',
          level: data['level'] ?? '',
          whatYoullLearn: List<String>.from(data['whatYoullLearn'] ?? []),
          schedule: (data['schedule'] as List?)?.map((s) => 
            WorkshopSchedule(
              title: s['title'] ?? '',
              activities: List<String>.from(s['activities'] ?? []),
            )
          ).toList() ?? [],
          materials: List<String>.from(data['materials'] ?? []),
          spotsAvailable: data['spotsAvailable'] ?? 0,
          totalSpots: data['totalSpots'] ?? 0,
        );
      }).toList();
    });
  }

 
  Future<void> bookWorkshop(String workshopId, String workshopTitle, String workshopDate) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');
    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('bookedWorkshops')
        .doc(workshopId)
        .set({
      'workshopId': workshopId,
      'title': workshopTitle,
      'date': workshopDate,
      'bookedAt': FieldValue.serverTimestamp(),
    });
  }

  
  Future<void> cancelBooking(String workshopId) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('bookedWorkshops')
        .doc(workshopId)
        .delete();
  }

  
  Future<List<Map<String, dynamic>>> getBookedWorkshops() async {
    final user = _auth.currentUser;
    if (user == null) return [];

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('bookedWorkshops')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'workshopId': data['workshopId'],
          'title': data['title'],
          'date': data['date'],
        };
      }).toList();
    } catch (e) {
      print('Error getting booked workshops: $e');
      return [];
    }
  }

  
  Stream<List<Map<String, dynamic>>> getBookedWorkshopsStream() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value([]);

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('bookedWorkshops')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'workshopId': data['workshopId'],
          'title': data['title'],
          'date': data['date'],
        };
      }).toList();
    });
  }

  
  Future<bool> isWorkshopBooked(String workshopId) async {
    final user = _auth.currentUser;
    if (user == null) return false;

    final doc = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('bookedWorkshops')
        .doc(workshopId)
        .get();

    return doc.exists;
  }
}