import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ReferScreen extends StatefulWidget {
  const ReferScreen({super.key});

  @override
  _ReferScreenState createState() => _ReferScreenState();
}

class _ReferScreenState extends State<ReferScreen> {
  late double width;
  late double height;
  String message =
      'Hey! I am gifting you \u{20B9}20 for your first WePedL ride. Enjoy!\nhttps://wepedl.page.link/CYAfu341CWybskBR9';
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Refer'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: width * 0.8,
              height: height * 0.4,
              child: const Image(
                image: AssetImage('assets/refer.png'),
              ),
            ),
          ),
          SizedBox(
            width: width * 0.9,
            height: height * 0.3,
            child: Card(
              color: Colors.blue[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      height: height * 0.15,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Refer WePedL to a friend & get \u{20B9}50 in wallet',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'When a friend signs up on the WePedL app using your link:',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                          const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '\u{2022} They get \u{20B9}20 in their wallet.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '\u{2022} You get \u{20B9}50 in your wallet when they take the first ride.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Share link via',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      SizedBox(width: width * 0.3),
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
