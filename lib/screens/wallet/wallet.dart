import 'dart:ffi';

import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 0, 0),
              child: Row(
                children: [
                  const Text(
                    'My',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    ' cards',
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadius.circular(17),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(0, 6),
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ]),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          '\u{20B9}3444',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        const Text(
                          'balance',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'refundable deposite',
                        ),
                        const Text(
                          '\u{20B9}240.00',
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            print('paid');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[400],
                          ),
                          child: const Text('paid'),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 0.3,
                          color: Colors.black,
                        ),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 7, 7, 7),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'â‚¹   All Transactions',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 7, 7, 7),
                                  child: ElevatedButton(
                                    child: const Text('>'),
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(39))),
                                      backgroundColor: Colors.blue,
                                      shadowColor: Colors.grey,
                                      elevation: 5,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                Container(
                  height: 40,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Add money',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shadowColor: Colors.grey,
                      elevation: 5,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
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
