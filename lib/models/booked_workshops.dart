

class BookedWorkshops {
  static List<Map<String, dynamic>> booked = [];

  static void addWorkshop(Map<String, dynamic> workshop) {
    booked.add(workshop);
  }

  static void removeWorkshop(int index) {
    booked.removeAt(index);
  }
}
