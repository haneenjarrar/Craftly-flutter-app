import '../data/mock_data.dart';
import '../services/workshop_service.dart';

class FirebaseSetup {
  final WorkshopService _workshopService = WorkshopService();

  
  Future<void> uploadMockDataToFirebase() async {
    print('Starting to upload workshops to Firebase...');
    
    try {
      for (var workshop in availableWorkshops) {
        await _workshopService.addWorkshop(workshop);
        print('Uploaded: ${workshop.title}');
      }
      
      print('All workshops uploaded successfully!');
    } catch (e) {
      print('Error uploading workshops: $e');
    }
  }
}
