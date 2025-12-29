import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/booked_workshops.dart';
import 'package:flutter_application_1/models/user.dart';

import '../models/workshop.dart';
import '../widgets/confirmation_dialog.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final workshop = ModalRoute.of(context)!.settings.arguments as Workshop;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'JD ${workshop.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF240046),
                  ),
                ),
                Text(
                  '${workshop.spotsAvailable} spots left',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8A008A),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () async {
                BookedWorkshops.addWorkshop({
                  'title': workshop.title,
                  'date': workshop.date,
                });
                showDialog(
      
                   context: context,
                   builder: (context) => ConfirmationDialog(
                   message: "Your spot is booked!",
                   ),
                );
               
              },
              child: Text('Book Now', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              workshop.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 300,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Icon(Icons.error, color: Colors.grey[600]),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workshop.title,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Text(
                        " ${workshop.rating}  •  ${workshop.duration}  •  ${workshop.level}",
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'About',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    workshop.fullDescription,
                    style: TextStyle(color: Colors.grey[700], height: 1.5),
                  ),
                  SizedBox(height: 20),

                  Text(
                    "What You'll Learn",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ...workshop.whatYoullLearn.map(
                    (e) => ListTile(
                      leading: Icon(Icons.check_circle, color: Colors.green),
                      title: Text(e),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),

                  SizedBox(height: 20),
                  Text(
                    'Instructor',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: Color(0xFF240046),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(workshop.instructor),
                    subtitle: Text(workshop.instructorBio),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
