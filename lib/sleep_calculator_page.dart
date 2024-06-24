import 'package:flutter/material.dart';

class SleepCalculatorPage extends StatefulWidget {
  @override
  _SleepCalculatorPageState createState() => _SleepCalculatorPageState();
}

class _SleepCalculatorPageState extends State<SleepCalculatorPage> {
  double _sleepHours = 8.0;

  String _getSleepFeedback(double hours) {
    if (hours < 5) {
      return 'Very Poor: Insufficient sleep can lead to severe health issues.';
    } else if (hours < 7) {
      return 'Poor: You might experience fatigue and decreased performance.';
    } else if (hours <= 9) {
      return 'Good: This is a healthy amount of sleep.';
    } else {
      return 'Very Good: But oversleeping might cause grogginess and other issues.';
    }
  }

  String _getEffectsOfSleep(double hours) {
    if (hours < 5) {
      return 'Effects: Severe lack of sleep can cause cognitive impairment, mood swings, and weakened immune system.';
    } else if (hours < 7) {
      return 'Effects: Mild lack of sleep can cause decreased alertness, poor performance, and increased stress.';
    } else if (hours <= 9) {
      return 'Effects: Optimal sleep promotes good health, improves memory, and enhances overall performance.';
    } else {
      return 'Effects: Oversleeping can cause headaches, back pain, and increased risk of chronic diseases.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sleep Calculator'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calculate Your Total Sleep',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.bed, size: 40, color: Colors.purple),
                SizedBox(width: 10),
                Text(
                  'Hours of Sleep:',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Slider(
              value: _sleepHours,
              min: 0,
              max: 24,
              divisions: 24,
              label: _sleepHours.round().toString(),
              onChanged: (value) {
                setState(() {
                  _sleepHours = value;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  _sleepHours < 5
                      ? Icons.error
                      : _sleepHours <= 9
                          ? Icons.check_circle
                          : Icons.warning,
                  color: _sleepHours < 5
                      ? Colors.red
                      : _sleepHours <= 9
                          ? Colors.green
                          : Colors.orange,
                  size: 40,
                ),
                SizedBox(width: 10),
                Text(
                  'Total Sleep: ${_sleepHours.round()} hours',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  _sleepHours < 5
                      ? Icons.error_outline
                      : _sleepHours <= 9
                          ? Icons.thumb_up
                          : Icons.warning_amber,
                  color: _sleepHours < 5
                      ? Colors.red
                      : _sleepHours <= 9
                          ? Colors.green
                          : Colors.orange,
                  size: 40,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _getSleepFeedback(_sleepHours),
                    style: TextStyle(
                      fontSize: 18,
                      color: _sleepHours < 5
                          ? Colors.red
                          : _sleepHours <= 9
                              ? Colors.green
                              : Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.info, size: 40, color: Colors.blue),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _getEffectsOfSleep(_sleepHours),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
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
