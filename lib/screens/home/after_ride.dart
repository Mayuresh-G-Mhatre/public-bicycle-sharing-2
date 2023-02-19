import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import 'home.dart';
import '../../services/shared_prefs.dart';

class AfterRideScreen extends StatefulWidget {
  var endRideTime;
  int rideFare;
  AfterRideScreen(
      {super.key, required this.endRideTime, required this.rideFare});
  @override
  State<AfterRideScreen> createState() => _AfterRideScreenState();
}

class _AfterRideScreenState extends State<AfterRideScreen> {
  String _selectedOption = '';
  String _feedback = '';
  double _emojiRating = 0;

  // shared pref //
  SharedPrefGetsNSets sprefs = SharedPrefGetsNSets();
  // shared pref //

  late int _amount;

  @override
  void initState() {
    super.initState();
    // shared pref //
    getWalletAmount();
    // shared pref //
  }

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Text(DateFormat('EEEE, MMMM d, y').format(DateTime.now()),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Ride Time: '),
                    Text(widget.endRideTime,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Ride Fare: '),
                    Text('\u{20B9}${widget.rideFare}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'How was your ride?',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                RatingBar.builder(
                  initialRating: _emojiRating,
                  itemCount: 5,
                  itemSize: 50,
                  allowHalfRating: false,
                  glow: true,
                  glowColor: Colors.blue,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Icon(
                          Icons.sentiment_very_dissatisfied,
                          color: _emojiRating == 1 ? Colors.red : Colors.grey,
                        );
                      case 1:
                        return Icon(
                          Icons.sentiment_dissatisfied,
                          color: _emojiRating == 2
                              ? Colors.redAccent
                              : Colors.grey,
                        );
                      case 2:
                        return Icon(
                          Icons.sentiment_neutral,
                          color: _emojiRating == 3 ? Colors.amber : Colors.grey,
                        );
                      case 3:
                        return Icon(
                          Icons.sentiment_satisfied,
                          color: _emojiRating == 4
                              ? Colors.lightGreen
                              : Colors.grey,
                        );
                      case 4:
                        return Icon(
                          Icons.sentiment_very_satisfied,
                          color: _emojiRating == 5 ? Colors.green : Colors.grey,
                        );
                      default:
                        return Container();
                    }
                    ;
                  },
                  onRatingUpdate: (rating) {
                    setState(() {
                      _emojiRating = rating;
                    });
                  },
                ),
                const SizedBox(height: 25),
                buildCheckItem("Issue while locking"),
                buildCheckItem("App froze"),
                buildCheckItem("Seat broken"),
                buildCheckItem("Location issue"),
                buildCheckItem("Other issues"),
                const SizedBox(height: 16.0),
                buildFeedbackForm(),
                const SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: () async {
                    await sprefs.setWalletAmount(_amount - widget.rideFare);
                    if (!mounted) return;
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (route) => false);
                  },
                  child: const Text('Done'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCheckItem(String option) {
    return RadioListTile<String>(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      title: Text(option),
      value: option,
      groupValue: _selectedOption,
      onChanged: (String? value) {
        setState(() {
          _selectedOption = value!;
        });
      },
    );
  }

  Widget buildFeedbackForm() {
    return SizedBox(
      height: 100,
      child: TextField(
        maxLines: 10,
        decoration: const InputDecoration(
          hintText: "Share your experience",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        onChanged: (value) {
          setState(() {
            _feedback = value;
          });
        },
      ),
    );
  }
}
