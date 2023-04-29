//Programmed by Brian Leong
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_coding_minds_application/community_service.dart';
import 'package:flutter_coding_minds_application/course_page.dart';
import 'package:flutter_coding_minds_application/job_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var userID = FirebaseAuth.instance.currentUser?.uid;
  String welcome = "Welcome ";

  String getUserName(String welcome){
    final ref = FirebaseDatabase.instance.ref("User$userID");
    ref.onValue.listen((DatabaseEvent event){
      final String response = jsonEncode(event.snapshot.value);
      Map<String, dynamic> data = json.decode(response); 
      welcome += data['name'];
    });
    return welcome;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getUserName(welcome), textAlign: TextAlign.center,), //We could output the name
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0)
          ),
        ),
        backgroundColor: Color.fromARGB(255, 244, 168, 54),
      ),
      body: ListView(
        children: <Widget>[
          //Active
          Card(
            child: ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CoursePage())),
              leading: const Icon(
                Icons.school,
                color: Color.fromARGB(255, 23, 3, 85),
              ),
              title: const Text('Academics'),
            ),
          ),

          //Community Service Opportunities
          Card(
            child: ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CommunityServicePage())),
              leading: const Icon(
                Icons.construction,
                color: Color.fromARGB(255, 63, 8, 230),
              ),
              title: const Text('Community Service Opportunities'),
            ),
          ),
          
          //Inactive 
          const Card(
            child: ListTile(
              leading: Icon(
                Icons.monetization_on,
                color: Color.fromARGB(255, 10, 110, 42),
              ),
              title: Text('Finances'),
            ),
          ),

          //Inactive
          Card(
            child: ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const JobPage())),
              leading: const Icon(
                Icons.work,
                color: Color.fromARGB(255, 176, 33, 8),
              ),
              title: const Text('Jobs and Internships'),
            ),
          ),

          //Inactive
          Card(
            child: ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const JobPage())),
              leading: const Icon(
                Icons.fitness_center,
                color: Color.fromARGB(255, 8, 159, 176),
              ),
              title: const Text('Physical Health'),
            ),
          ),

          //Inactive
          Card(
            child: ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const JobPage())),
              leading: const Icon(
                Icons.people,
                color: Color.fromARGB(255, 176, 8, 126),
              ),
              title: const Text('Social'),
            ),
          ),

          //Inactive
          const Card(
            child: ListTile(
              leading: Icon(
                Icons.settings,
                color: Color.fromARGB(255, 66, 63, 56),
              ),
              title: Text('User Settings'),
            ),
          ),
        ],
      ),
    );
  }
}

