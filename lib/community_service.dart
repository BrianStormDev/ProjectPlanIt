import 'package:flutter/material.dart';
import 'package:flutter_coding_minds_application/user_page.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunityServicePage extends StatefulWidget {
  const CommunityServicePage({super.key});

  @override
  State<CommunityServicePage> createState() => _CommunityServicePageState();
}

final Uri _urlVolunteerMatch = Uri.parse("https://www.volunteermatch.org/");
final Uri _urlEngage = Uri.parse("https://engage.pointsoflight.org/");
final Uri _urlJustServe = Uri.parse("https://www.justserve.org/");

class _CommunityServicePageState extends State<CommunityServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            leading: BackButton(onPressed:() => Navigator.push(context, MaterialPageRoute(builder: (context) => const UserPage())),),
            title: const Text("Community Service"),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0)
              ),
            ),
            backgroundColor: Color.fromARGB(255, 33, 176, 8),
          ),
          const Text("Select any of the following options to get started with helping your community :)"),
          Container(
            margin: const EdgeInsets.all(20),
            height: 50,
            width: 200,
            child: const ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 239, 44, 10)),
              ),
              onPressed: _launchVolunteerMatch,
              child: Text(
                "VolunteerMatch",
                style: TextStyle(color: Color.fromARGB(255, 1, 0, 10),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            height: 50,
            width: 200,
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 235, 235, 15)),
              ),
              onPressed: _launchEngage,
              child: Container(
                margin: const EdgeInsets.all(20),
                child: const Text("Engage",
                style: TextStyle(color: Colors.black,),
              )),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            height: 50,
            width: 200,
            child: const ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 4, 229, 192)),
              ),
              onPressed: _launchJustServe,
              child: Text("Just Serve",
                style: TextStyle(color: Colors.black,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _launchVolunteerMatch() async {
  if (!await launchUrl(_urlVolunteerMatch)) {
    throw Exception('Could not launch $_urlVolunteerMatch');
  }
}

Future<void> _launchEngage() async {
  if (!await launchUrl(_urlEngage)) {
    throw Exception('Could not launch $_urlEngage');
  }
}

Future<void> _launchJustServe() async {
  if (!await launchUrl(_urlJustServe)) {
    throw Exception('Could not launch $_urlJustServe');
  }
}