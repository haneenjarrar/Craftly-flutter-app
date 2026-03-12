import 'package:flutter/material.dart';
import '../widgets/workshop_card.dart';
import '../models/workshop.dart';
import '../services/workshop_service.dart';
import '../services/auth_service.dart';
import '../screens/booked_workshops_screen.dart';
import '../utils/widgets_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WorkshopService _workshopService = WorkshopService();
  final AuthService _authService = AuthService();
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Workshop> _allWorkshops = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWorkshops();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadWorkshops() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final workshops = await _workshopService.getAllWorkshops();
      setState(() {
        _allWorkshops = workshops;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading workshops: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Workshop> get _filteredWorkshops {
    List<Workshop> workshops = _allWorkshops;

    if (_selectedCategory != 'All') {
      workshops = workshops
          .where((workshop) => workshop.category == _selectedCategory)
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      workshops = workshops.where((workshop) {
        return workshop.title.toLowerCase().contains(query) ||
            workshop.instructor.toLowerCase().contains(query) ||
            workshop.category.toLowerCase().contains(query);
      }).toList();
    }

    return workshops;
  }
    /*using a set instead of list prevents duplicates */
  List<String> get _categories {
    final categories = <String>{'All'};
    for (var workshop in _allWorkshops) {
      categories.add(workshop.category);
    }
    return categories.toList();
  }

  Future<void> _handleSignOut() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sign Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _authService.signOut();
        if (mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/welcome',
            (route) => false,
          );
          Future.microtask(() {
            if (mounted) {
              Navigator.pushNamed(context, '/login');
            }
          });
        }
      } catch (e) {
        if (mounted) {
          WidgetsHelper.showSnackBar(
            context,
            'Error signing out: $e',
            isError: true,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
                         /*this is for the header */
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text(
                            'Craftly',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.stars, color: Colors.white),
                        ]),
                        Text(
                          'Welcome!',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    
                    PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 30,
                      ),
                      offset: const Offset(0, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onSelected: (value) {
                        if (value == 'booked') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const BookedWorkshopsScreen(),
                            ),
                          );
                        } else if (value == 'signout') {
                          _handleSignOut();
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<String>(
                          value: 'booked',
                          child: Row(
                            children: const [
                              Icon(Icons.bookmark, color: Color(0xFF8A008A)),
                              SizedBox(width: 12),
                              Text('Booked Workshops'),
                            ],
                          ),
                        ),
                        const PopupMenuDivider(),
                        PopupMenuItem<String>(
                          value: 'signout',
                          child: Row(
                            children: const [
                              Icon(Icons.logout, color: Colors.red),
                              SizedBox(width: 12),
                              Text(
                                'Sign Out',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search workshops...',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ],
            ),
          ),

          
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: Chip(
                      label: Text(category),
                      backgroundColor: isSelected
                          ? const Color(0xFF240046)
                          : Colors.grey[200],
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /*basically checks if page is loading then show circular progress indicator, if its not loading
          and its empty show no workshops found, but if its not loading and its not empty like there's workshops 
          user can refresh the list using refresh indicator */
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _filteredWorkshops.isEmpty
                    ? Center(
                        child: Text(
                          'No workshops found',
                          style: TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _loadWorkshops,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(20),
                          itemCount: _filteredWorkshops.length,
                          itemBuilder: (context, index) {
                            return WorkshopCard(
                              workshop: _filteredWorkshops[index],
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}