//Programmed by Brian Leong
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_coding_minds_application/add_course.dart';
import 'package:flutter_coding_minds_application/user_page.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://assist.org/');

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class Course{
  String category;
  String name;
  int number;
  int units;

  Course(this.category,this.name,this.number,this.units);
}

class _CoursePageState extends State<CoursePage> {
  final List _courses = [];
  var userID = FirebaseAuth.instance.currentUser?.uid;

  _CoursePageState(){
    DatabaseReference courseRef = FirebaseDatabase.instance.ref().child("User$userID/Courses");
    courseRef.onValue.listen((DatabaseEvent event) {

      setState(() {
        if (event.snapshot.exists && event.snapshot.value!="null"){ //If database is not empty, we can grab from database
          final String response = jsonEncode(event.snapshot.value); //Get the snapshot value as a Json String
          //Parse JSON string
          Map<String,dynamic> data = json.decode(response);
          for (String key in data.keys){
            Map<String, dynamic> course = data[key];
            //Access fields in nested map
            Course thing = Course(course['category'],course['name'],int.parse(course['number']),int.parse(course['units']));
            if (!_courses.contains(thing)){
              _courses.add(thing);
            }
          listCourses(_courses);
          }
        }});
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            leading: BackButton(onPressed:() => Navigator.push(context, MaterialPageRoute(builder: (context) => const UserPage())),),
            title: const Text("Add Courses",
            textAlign: TextAlign.center,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0)
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 23, 3, 85),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: const [
                Text("For transfers, check Assist.org to figure out which classes to take"),
                Text("1. Select the college you are transferring from and the college you are transferring to"),
                Text("2. Find your major"),
                Text("3. Click on articulation agreement"),
                Text("4. Add courses to this app"),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            height: 50,
            width: 300,
            child: const ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.deepPurple),
              ),
              onPressed: _launchUrl,
              child: Text("Assist Transfer Agreements"),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            height: 50,
            child: ElevatedButton(
              onPressed: (){
                
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCoursePage()));
              },
              child: const Text("Add Course"),
            ),
          ),
          listCourses(_courses),
        ],
      ),
    );
  }
}

Widget listCourses(var courseList){
    if (courseList.length == 0){
      return const Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text("You have no courses registered"),
        ),
      );
    }
    else{
      return ListView.builder(
        shrinkWrap: true,
        itemCount: courseList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              onTap: () => courseList.remove(index), //remove Item needs to be fixed
              trailing: const Icon(
                Icons.cancel,
                color: Color.fromARGB(255, 215, 66, 11),),
              title: Text('${courseList[index].category.toString().toUpperCase()}-${courseList[index].number}: ${courseList[index].name} (${courseList[index].units} units)'
              ),
            ),
          );
        }
    );
  }
}

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
