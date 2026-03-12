import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/workshop_service.dart';
import 'package:flutter_application_1/utils/app_styles.dart';

class BookedWorkshopsScreen extends StatefulWidget {
  const BookedWorkshopsScreen({super.key});

  @override
  State<BookedWorkshopsScreen> createState() => _BookedWorkshopsScreenState();
}

class _BookedWorkshopsScreenState extends State<BookedWorkshopsScreen> {
  final WorkshopService _workshopService = WorkshopService();
   /*I used stream builder because my data is real time and can change while the app is running and 
   so it can rebuild the UI automatically whenever the list changes*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppStyles.buildAppBar('My Booked Workshops'),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _workshopService.getBookedWorkshopsStream(),
        builder: (context, snapshot) {
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    'Error loading bookings',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          
          final bookedWorkshops = snapshot.data ?? [];

          
          if (bookedWorkshops.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No booked workshops yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Book workshops to see them here',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            );
          }

          
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: bookedWorkshops.length,
            itemBuilder: (context, index) {
              final workshop = bookedWorkshops[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.bookmark,
                    color: AppStyles.primaryColor,
                  ),
                  title: Text(
                    workshop['title'] ?? 'Unknown Workshop',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(workshop['date'] ?? 'No date'),
                  trailing: IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.red),
                    onPressed: () async {
                      
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Cancel Booking'),
                          content: const Text(
                            'Are you sure you want to cancel this booking?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text(
                                'Yes',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );

                      
                      if (confirm == true) {
                        try {
                          await _workshopService.cancelBooking(
                            workshop['workshopId'],
                          );
                        
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}