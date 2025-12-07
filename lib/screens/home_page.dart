import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../widgets/workshop_card.dart';
import '../models/user.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
   
    final args = ModalRoute.of(context)?.settings.arguments;
    
    User user;

    
    if (args != null && args is User) {
      user = args; 
    } else {
     
      user = User(uid: 'guest', email: 'guest@craftly.com', name: 'Guest');
    }
    

    return Scaffold(
      body: Column(
        children: [
          
          Container(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF240046), Color(0xFF8A008A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Craftly', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                        
                        Text('Welcome, ${user.name}', style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                    Icon(Icons.stars, color: Colors.white, size: 30),
                  ],
                ),
                SizedBox(height: 20),
                
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search workshops...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  ),
                ),
              ],
            ),
          ),

          
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Chip(
                    label: Text(categories[index]),
                    backgroundColor: index == 0 ? Color(0xFF240046) : Colors.grey[200],
                    labelStyle: TextStyle(color: index == 0 ? Colors.white : Colors.black),
                  ),
                );
              },
            ),
          ),

        
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: availableWorkshops.length,
              itemBuilder: (context, index) {
                return WorkshopCard(workshop: availableWorkshops[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}