import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  TransactionsScreen({super.key});

  final List<String> dateTime = [
    '01 Jan 2022 08:35 AM',
    '08 Jan 2022 09:31 AM',
    '19 Jan 2022 06:02 PM',
    '04 Mar 2022 07:15 AM',
    '12 Mar 2022 08:46 AM',
    '24 May 2022 07:05 PM',
    '06 Jun 2022 07:52 AM',
    '29 Jun 2022 05:22 AM',
    '15 Sep 2022 10:15 AM',
    '22 Nov 2022 09:25 AM',
  ];

  final List<String> amountList = [
    '50',
    '20',
    '100',
    '10',
    '15',
    '90',
    '30',
    '25',
    '10',
    '40',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            dense: true,
            leading: const Icon(
              Icons.account_balance_wallet,
              size: 32,
              color: Colors.blue,
            ),
            title: const Text(
              'Wallet Top-Up',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              dateTime[index],
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            trailing: Text(
              '\u{20B9}${amountList[index]}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
