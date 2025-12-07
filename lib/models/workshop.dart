class WorkshopSchedule {
  final String title;
  final List<String> activities;

  WorkshopSchedule({required this.title, required this.activities});
}


class Workshop {
  final String id; 
  final String title;
  final String description; 
  final String fullDescription; 
  final String imageUrl;
  final String category; 
  final String location; 
  final String address; 
  final String date; 
  final String time; 
  final double rating;
  final String instructor;
  final String instructorBio;
  final String contactEmail;
  final String contactPhone;
  final double price;
  final String duration; 
  final String level; 
  final List<String> whatYoullLearn;
  final List<WorkshopSchedule> schedule;
  final List<String> materials;
  final int spotsAvailable;
  final int totalSpots;


  Workshop({
    required this.id,
    required this.title,
    required this.description,
    required this.fullDescription,
    required this.imageUrl,
    required this.category,
    required this.location,
    required this.address,
    required this.date,
    required this.time,
    this.rating = 0.0,
    required this.instructor,
    required this.instructorBio,
    required this.contactEmail,
    required this.contactPhone,
    required this.price,
    required this.duration,
    required this.level,
    required this.whatYoullLearn,
    required this.schedule,
    required this.materials,
    required this.spotsAvailable,
    required this.totalSpots,
  });
}
