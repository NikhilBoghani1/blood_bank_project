import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EmergencyCallScreen extends StatefulWidget {
  const EmergencyCallScreen({Key? key});

  @override
  State<EmergencyCallScreen> createState() => _EmergencyCallScreenState();
}

class _EmergencyCallScreenState extends State<EmergencyCallScreen> {
  Future<void> sendSms(String phoneNumber, String message) async {
    String url = 'sms:$phoneNumber?body=$message';

    bool result = await canLaunchUrlString(url);

    try {
      if (result) {
        await launchUrlString(url);
      } else {
        throw Exception('Could not launch');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> dial(String contact) async {
    String url = 'tel:$contact';

    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        print(true);
        await launchUrl(Uri.parse(url));
      } else {
        throw Exception('Could not launch');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Emergency'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text(
                    'Send SMS',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    for (int i = 0; i < 50; i++) {
                      sendSms('+919714381004', 'Hello, this is a test message');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Set the border radius
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Set the border radius
                    ),
                  ),
                  child: Text(
                    'Dial Number',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    dial('8866634508');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}