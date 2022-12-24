import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ReferScreen extends StatefulWidget {
  const ReferScreen({super.key});

  @override
  _ReferScreenState createState() => _ReferScreenState();
}

class _ReferScreenState extends State<ReferScreen> {
  String message =
      'Hey%21%20I%20am%20gifting%20you%20%E2%82%B920%20for%20your%20first%20WePedL%20ride.%20Enjoy%21%20https%3A%2F%2Fwepedl.page.link%2FCYAfu341CWybskBR9';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Refer'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Image(
              width: 250,
              height: 250,
              image: AssetImage('assets/refer.png'),
            ),
            // const SizedBox(height: 5.0),
            Container(
              padding: const EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width - 10,
              height: MediaQuery.of(context).size.height / 2.5,
              child: Card(
                color: Colors.blue[100],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text(
                              'Refer WePedL to a friend & get \u{20B9}50 in wallet',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            const Text(
                              'When a friend signs up on the WePedL app using your link:',
                              style: TextStyle(fontSize: 12.0),
                            ),
                            const Text(
                              '\u{2022} They get \u{20B9}20 in their wallet',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.0,
                              ),
                            ),
                            const Text(
                              '\u{2022} You get \u{20B9}50 in your wallet when they take the first ride',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Share link via',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 15),
                        SizedBox(
                          width: 100,
                          height: 27,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 1,
                            ),
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                const url = 'https://wa.me/';
                                final uri = Uri.parse('$url?text=$message');
                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(uri);
                                } else {
                                  throw 'Could not launch $uri';
                                }
                              },
                              icon: const Icon(
                                Icons.whatsapp,
                                size: 15,
                              ),
                              label: const Text('WhatsApp',
                                  style: TextStyle(fontSize: 10.2)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          height: 30,
                          width: 30,
                          // padding: const EdgeInsets.all(8),
                          // margin: const EdgeInsets.only(top: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Share.share(message);
                            },
                            icon: const Icon(
                              Icons.share,
                              size: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        );
  }
}
