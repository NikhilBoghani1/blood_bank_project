import 'package:blood_bank/admin_module/model/admin_class.dart';
import 'package:blood_bank/database_helper/db_helper.dart';
import 'package:blood_bank/user_module/user_screen/requestblood_screen.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../user_screen/emergenacy_screen.dart';
import '../user_screen/user_view_donor.dart';

class UserDashboardScreen extends StatefulWidget {
  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  late Future<List<Donor>> _donorsFuture;

  List<Donor> _filteredDonors = [];

  List<Donor> _allDonors = [];

  @override
  void initState() {
    super.initState();
    _donorsFuture = _fetchDonors();
  }

  Future<List<Donor>> _fetchDonors() async {
    List<Donor> donors = await DatabaseHelper().getDonors();
    setState(() {
      _allDonors = donors;
      _filteredDonors = donors;
    });
    return donors;
  }

  void _filterDonors(String query) {
    List<Donor> filteredList = _allDonors.where((donor) {
      return donor.name.toLowerCase().contains(query.toLowerCase()) ||
          donor.bloodGroup.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      _filteredDonors = filteredList;
    });
  }

  void _requestBlood(Donor donor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Request Blood'),
        content: Text('Request blood from ${donor.name}?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _submitRequest(donor);
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('No'),
          ),
        ],
      ),
    );
  }

  void _submitRequest(Donor donor) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RequestBloodScreen(donor: donor)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('User Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          /* padding: EdgeInsets.zero,*/
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/image/drawer_image.png")),
              ),
              child: Container(),
            ),
            ListTile(
              leading: Icon(
                Icons.people,
                color: Colors.black,
              ),
              title: Text(
                'User View Donors',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserViewDonorsScreen()),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Divider(
                height: 1,
                thickness: 2,
                color: Colors.grey,
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.black),
              title: Text(
                'Emergency Call',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmergencyCallScreen()),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Divider(
                height: 1,
                thickness: 2,
                color: Colors.grey,
              ),
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.black),
              title: Text(
                'About Us',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to About Us screen or show a dialog
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Divider(
                height: 1,
                thickness: 2,
                color: Colors.grey,
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.black),
              title: Text(
                'Settings',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to Settings screen or show a dialog
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Divider(
                height: 1,
                thickness: 2,
                color: Colors.grey,
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined, color: Colors.black),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (Route<dynamic> route) => false,
                ); // Navigate to HomeScreen
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: TextField(
                onChanged: (value) {
                  _filterDonors(value);
                },
                decoration: InputDecoration(
                  labelText: 'Search Donors',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Donor>>(
                future: _donorsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return ListView.builder(
                      itemCount: _filteredDonors.length,
                      itemBuilder: (context, index) {
                        Donor donor = _filteredDonors[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 22, right: 22, top: 10),
                          child: Card(
                            color: Colors.grey.shade100,
                            child: ListTile(
                              title: Text(donor.name),
                              subtitle: Text(donor.bloodGroup),
                              trailing: IconButton(
                                icon: Icon(Icons.bloodtype,
                                    color: Colors.red.shade300),
                                onPressed: () => _requestBlood(donor),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}