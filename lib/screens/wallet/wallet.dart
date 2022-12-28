import 'package:flutter/material.dart';
import 'package:public_bicycle_sharing/services/shared_prefs.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  // shared pref //
  SharedPrefGetsNSets sprefs = SharedPrefGetsNSets();
  // shared pref //

  late bool _paid;
  late int _amount;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    // shared pref //
    getDepositStatus();
    getWalletAmount();
    // shared pref //
  }

  // shared pref //
  Future<void> getDepositStatus() async {
    bool? paid = await sprefs.getDepositStatus();
    setState(() {
      _paid = paid!;
    });
  }
  // shared pref //

  // shared pref //
  Future<void> getWalletAmount() async {
    int? amount = await sprefs.getWalletAmount();
    setState(() {
      _amount = amount!;
    });
  }
  // shared pref //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 0, 0),
              child: Row(
                children: const [
                  Text(
                    'Wallet',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
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
                        Text(
                          '\u{20B9}$_amount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        const Text(
                          'Balance',
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
                          'Refundable Deposit',
                        ),
                        const Text(
                          '\u{20B9}200',
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _paid
                              ? null
                              : () async {
                                  Fluttertoast.showToast(
                                    msg: 'Paid Successfully',
                                    gravity: ToastGravity.BOTTOM,
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                  setState(() {
                                    _paid = true;
                                  });
                                  await sprefs.setDepositStatus(_paid);
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[400],
                            disabledBackgroundColor: Colors.green,
                          ),
                          child: Text(_paid ? 'Paid' : 'Pay Now'),
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
                                children: const [
                                  Text(
                                    'All Transactions',
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
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(39))),
                                      backgroundColor: Colors.blue,
                                      shadowColor: Colors.grey,
                                      elevation: 5,
                                    ),
                                    child: const Text('>'),
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
                    onPressed: () async {
                      await showPaymentDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shadowColor: Colors.grey,
                      elevation: 5,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                    child: const Text(
                      'Add money',
                      style: TextStyle(
                        fontSize: 18,
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

  Future<void> showPaymentDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                title: const Text('Pay Wall'),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          _counter--;
                        });
                      },
                    ),
                    const SizedBox(width: 10.0),
                    Text(_counter.toString()),
                    const SizedBox(width: 10.0),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          _counter++;
                        });
                      },
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      setState(() {
                        _counter = 0;
                      });
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await sprefs.setWalletAmount(_amount + _counter);
                      setState(() {
                        _amount = _amount + _counter;
                        _counter = 0;
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text('Pay'),
                  ),
                ],
              ),
            );
          });
        }).whenComplete(() {
      setState(() {});
    });
  }
}
