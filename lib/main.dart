import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'admin_module/admin_main_dashboard_screen/dashboard_admin_side.dart';
import 'database_helper/db_helper.dart';
import 'user_module/user_main_dashboard_screen/dashboard_user_side.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().database;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blood Bank Management System',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminDashboardScreen()),
                    );
                  },
                  child: Container(
                    width: 200,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    /*  width: MediaQuery.of(context).size.width,*/
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200,
                    ),
                    child: Center(
                      child: Text(
                        "Admin Module",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserDashboardScreen()),
                  );
                },
                child: Container(
                  width: 200,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  /*   width: MediaQuery.of(context).size.width,*/
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200,
                  ),
                  child: Center(
                    child: Text(
                      "User Module",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}