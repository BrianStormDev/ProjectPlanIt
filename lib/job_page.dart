import 'package:flutter/material.dart';
import 'package:flutter_coding_minds_application/user_page.dart';
import 'package:url_launcher/url_launcher.dart';

class JobPage extends StatefulWidget {
  const JobPage({super.key});

  @override
  State<JobPage> createState() => _JobPageState();
}

final Uri _urlLinkedIn = Uri.parse("https://www.linkedin.com/");
final Uri _urlIndeed = Uri.parse("https://www.indeed.com/");
final Uri _urlHandshake = Uri.parse("https://joinhandshake.com/");
final Uri _urlGlassDoor = Uri.parse("https://www.glassdoor.com");

class _JobPageState extends State<JobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            leading: BackButton(onPressed:() => Navigator.push(context, MaterialPageRoute(builder: (context) => const UserPage())),),
            title: const Text("Jobs and Internships"),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0)
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 176, 33, 8),
          ),
          const Text("You miss 100% of the shots you don't take, so start applying! Apply using any of the links below and log your applications", textAlign: TextAlign.center),
          Container(
            margin: const EdgeInsets.all(20),
            height: 50,
            width: 200,
            child: const ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 12, 22, 214)),
              ),
              onPressed: _launchLinkedIn,
              child: Text(
                "LinkedIn",
                style: TextStyle(color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            height: 50,
            width: 200,
            child: const ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 187, 235, 15)),
              ),
              onPressed: _launchHandshake,
              child: Text("Handshake",
                style: TextStyle(color: Colors.black,),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            height: 50,
            width: 200,
            child: const ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 16, 6, 126)),
              ),
              onPressed: _launchIndeed,
              child: Text("Indeed",
                style: TextStyle(color: Colors.white,),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            height: 50,
            width: 200,
            child: const ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 2, 241, 94)),
              ),
              onPressed: _launchGlassDoor,
              child: Text("GlassDoor",
                style: TextStyle(color: Colors.black,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _launchLinkedIn() async {
  if (!await launchUrl(_urlLinkedIn)) {
    throw Exception('Could not launch $_urlLinkedIn');
  }
}

Future<void> _launchIndeed() async {
  if (!await launchUrl(_urlIndeed)) {
    throw Exception('Could not launch $_urlIndeed');
  }
}

Future<void> _launchHandshake() async {
  if (!await launchUrl(_urlHandshake)) {
    throw Exception('Could not launch $_urlHandshake');
  }
}

Future<void> _launchGlassDoor() async {
  if (!await launchUrl(_urlGlassDoor)) {
    throw Exception('Could not launch $_urlGlassDoor');
  }
}