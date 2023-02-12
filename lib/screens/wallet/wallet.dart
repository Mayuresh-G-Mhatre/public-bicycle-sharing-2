import 'package:flutter/material.dart';
import 'package:public_bicycle_sharing/screens/wallet/transactions.dart';
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

  late double width;
  late double height;

  TextEditingController amountController = TextEditingController();
  TextEditingController depositController = TextEditingController(text: '200');

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
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 15,
              ),
              child: Text(
                'Wallet',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.shade400,
                  //     offset: const Offset(0, 6),
                  //     blurRadius: 10,
                  //     spreadRadius: 2,
                  //   )
                  // ],
                ),
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
                            onPressed: _paid
                                ? null
                                : () async {
                                    await showDepositPaymentDialog(context);
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[400],
                              disabledBackgroundColor: Colors.green,
                            ),
                            child: Text(
                              _paid ? 'Paid' : 'Pay Now',
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
                    onPressed: _paid
                        ? () async {
                            await showPaymentDialog(context);
                          }
                        : () {
                            Fluttertoast.showToast(
                              msg: 'Pay Security Deposit First',
                              gravity: ToastGravity.BOTTOM,
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
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
                      Fluttertoast.showToast(
                        msg: 'Paid Successfully',
                        gravity: ToastGravity.BOTTOM,
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      setState(() {
                        _paid = true;
                      });
                      await sprefs.setDepositStatus(_paid);

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
                    onPressed: () async {
                      await sprefs.setWalletAmount(
                          _amount + int.parse(amountController.text));
                      setState(() {
                        _amount = _amount + int.parse(amountController.text);
                      });

                      amountController.clear();

                      Fluttertoast.showToast(
                        msg: 'Top-Up Successfull',
                        gravity: ToastGravity.BOTTOM,
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
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
}
