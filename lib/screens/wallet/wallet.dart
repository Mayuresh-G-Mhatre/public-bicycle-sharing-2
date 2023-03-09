import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'transactions.dart';
import '../../services/shared_prefs.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with WidgetsBindingObserver {
  // shared pref //
  SharedPrefGetsNSets sprefs = SharedPrefGetsNSets();
  // shared pref //

  String _phoneNumber = '';

  late double width;
  late double height;

  TextEditingController amountController = TextEditingController();
  TextEditingController depositController = TextEditingController(text: '200');

  int balance = 0;
  bool depositPaid = false;

  @override
  void initState() {
    // getPhoneNumberAndReadDatabase();
    // fetch details from database
    // getUserDetailsFS();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getPhoneNumberAndReadDatabase();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // shared pref //
  Future<void> getPhoneNumberAndReadDatabase() async {
    String? phoneNumber = await sprefs.getPhoneNumber();
    setState(() {
      _phoneNumber = phoneNumber!;
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(_phoneNumber)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          balance = documentSnapshot.get('balance') ?? 0;
          depositPaid = documentSnapshot.get('deposit_paid') ?? false;
        });
      }
    });
  }
  // shared pref //

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: 8,
            //     vertical: 15,
            //   ),
            //   child: Text(
            //     'Wallet',
            //     style: TextStyle(
            //       fontSize: 16,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: width * 0.9,
                height: height * 0.22,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.09,
                  vertical: height * 0.05,
                ),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '\u{20B9}$balance',
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          const Text(
                            'Balance',
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Security Deposit',
                          ),
                          const Text(
                            '\u{20B9}200',
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: depositPaid
                                ? null
                                : () async {
                                    await showDepositPaymentDialog(context);
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[400],
                              disabledBackgroundColor: Colors.green,
                            ),
                            child: Text(
                              depositPaid ? 'Paid' : 'Pay Now',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100],
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    width: 0.3,
                    color: Colors.black,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'All Transactions',
                      style: TextStyle(
                        // color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TransactionsScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(39),
                          ),
                        ),
                        backgroundColor: Colors.blue,
                        shadowColor: Colors.grey,
                        elevation: 5,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                        size: 15,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 15,
                ),
                child: SizedBox(
                  height: height * 0.06,
                  width: width * 0.45,
                  child: ElevatedButton(
                    onPressed: depositPaid
                        ? () async {
                            await showPaymentDialog(context);
                          }
                        : () {
                            showToast('Pay security deposit first');
                          },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Add money',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showDepositPaymentDialog(BuildContext context) async {
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
                title: const Text('Pay Now'),
                content: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: TextField(
                    enabled: false,
                    readOnly: true,
                    controller: depositController,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.currency_rupee,
                      ),
                    ),
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      showToast('Paid Successfully');
                      setState(() {
                        depositPaid = true;
                      });
                      updateDatabase(_phoneNumber);

                      if (!mounted) return;
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
                title: const Text('Enter Amount'),
                content: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: TextField(
                    controller: amountController,
                    autofocus: true,
                    maxLength: 3,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.currency_rupee,
                      ),
                    ),
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (amountController.text.isEmpty) {
                        showToast('Invalid amount');
                      } else {
                        setState(() {
                          balance = balance + int.parse(amountController.text);
                        });

                        updateDatabase(_phoneNumber);

                        amountController.clear();

                        showToast('Top-Up Successfull');
                        if (!mounted) return;
                        Navigator.of(context).pop();
                      }
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

  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future updateDatabase(String phoneNumber) async {
    final DocumentReference documentRef =
        FirebaseFirestore.instance.collection('users').doc(phoneNumber);

    final DocumentSnapshot documentSnapshot = await documentRef.get();

    if (documentSnapshot.exists) {
      await documentRef.update({
        'balance': balance,
        'deposit_paid': depositPaid,
      });

      getPhoneNumberAndReadDatabase();
    }
  }
}
