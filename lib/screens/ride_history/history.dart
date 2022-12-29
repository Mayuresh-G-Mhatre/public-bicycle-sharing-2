import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
    '01 Jan 2023 08:35 AM',
    '08 Jan 2023 09:31 AM',
    '19 Jan 2023 06:02 PM',
    '04 Mar 2023 07:15 AM',
    '12 Mar 2023 08:46 AM',
    '24 May 2023 07:05 PM',
    '06 Jun 2023 07:52 AM',
    '29 Jun 2023 05:22 AM',
    '15 Sep 2023 10:15 AM',
    '22 Nov 2023 09:25 AM',
  ];

  final List<String> amountList = [
    '50',
    '20',
    '10',
    '100',
    '90',
    '15',
    '30',
    '40',
    '10',
    '25',
    '10',
    '50',
    '20',
    '90',
    '15',
    '30',
    '25',
    '10',
    '100',
    '40',
  ];

  final List<String> plateNumber = [
    '10206',
    '13450',
    '17516',
    '14620',
    '11010',
    '10648',
    '17612',
    '11647',
    '19456',
    '13248',
    '10206',
    '14620',
    '13450',
    '17516',
    '11010',
    '10648',
    '19456',
    '11647',
    '17612',
    '13248',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.pedal_bike),
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bicycle ${plateNumber[index]}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2.5),
                          Text(
                            dateTime[index],
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\u{20B9}${amountList[index]}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
