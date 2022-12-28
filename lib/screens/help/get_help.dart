import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class GetHelpScreen extends StatefulWidget {
  const GetHelpScreen({super.key});

  @override
  _GetHelpScreenState createState() => _GetHelpScreenState();
}

class _GetHelpScreenState extends State<GetHelpScreen> {
  late double width;
  late double height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              child: Text(
                'Need Help?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: width * 0.8,
                height: height * 0.3,
                child: const Image(
                  image: AssetImage('assets/help.png'),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Text(
                'F.A.Q',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Accordion(
              children: [
                AccordionSection(
                  header: const Text('How to use?'),
                  content: const Text(
                      '1. Topup your wallet\n2. Scan QR Code to unlock.\n3. Start Ride.\n4. Go to nearby station, scan QR Code and end ride.'),
                  // headerPadding: EdgeInsets.symmetric(horizontal: 20),
                  headerBackgroundColor: Colors.blue[200],
                  headerBackgroundColorOpened: Colors.grey,
                ),
                AccordionSection(
                  header: const Text('What if lost internet connectivity?'),
                  content: const Text(
                      'Incase you lost internet connection or phone powers off during ride, you will have to return the bicycle to station within 15 minutes. It will lock itself after 15 minutes and if not returned to station, legal action will be taken.'),
                  // headerPadding: EdgeInsets.symmetric(horizontal: 20),
                  headerBackgroundColor: Colors.blue[200],
                  headerBackgroundColorOpened: Colors.grey,
                ),
                AccordionSection(
                  header:
                      const Text('How to I get refund of security deposit?'),
                  content: const Text(
                      'Go to Settings and you will find an option to delete account. After deleting, refund will be credited to your account in 3-4 working days. If no refund has been recieved, contact us via customer care or email.'),
                  // headerPadding: EdgeInsets.symmetric(horizontal: 20),
                  headerBackgroundColor: Colors.blue[200],
                  headerBackgroundColorOpened: Colors.grey,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 70,
                  width: 70,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.mail,
                          size: 25,
                        ),
                        Text(
                          'Mail',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      String email = 'wepedlcare@gmail.com';
                      Uri emailUrl = Uri.parse('mailto:$email');

                      if (await canLaunchUrl(emailUrl)) {
                        await launchUrl(emailUrl);
                      } else {
                        throw 'Error occured sending an email';
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 70,
                  width: 70,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.call,
                          size: 25,
                        ),
                        Text(
                          'Contact',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      String tollFreeNumber = '+18008969999';
                      Uri tollFreeNumberUrl = Uri.parse('tel:$tollFreeNumber');

                      if (await canLaunchUrl(tollFreeNumberUrl)) {
                        await launchUrl(tollFreeNumberUrl);
                      } else {
                        throw 'Error occured trying to call';
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
