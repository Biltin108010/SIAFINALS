import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_helper.dart';

class SleepCalculatorPage extends StatefulWidget {
  @override
  _SleepCalculatorPageState createState() => _SleepCalculatorPageState();
}

class _SleepCalculatorPageState extends State<SleepCalculatorPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TextEditingController _hoursController = TextEditingController();
  String _feedbackMessage = '';
  String _effectsMessage = '';

  @override
  void dispose() {
    _hoursController.dispose();
    super.dispose();
  }

  void _calculateSleepFeedback(double hours) {
    setState(() {
      if (hours < 5) {
        _feedbackMessage =
            'Very Poor: Insufficient sleep can lead to severe health issues.';
        _effectsMessage =
            'Effects: Severe lack of sleep can cause cognitive impairment, mood swings, and weakened immune system.';
      } else if (hours < 7) {
        _feedbackMessage =
            'Poor: You might experience fatigue and decreased performance.';
        _effectsMessage =
            'Effects: Mild lack of sleep can cause decreased alertness, poor performance, and increased stress.';
      } else if (hours <= 9) {
        _feedbackMessage = 'Good: This is a healthy amount of sleep.';
        _effectsMessage =
            'Effects: Optimal sleep promotes good health, improves memory, and enhances overall performance.';
      } else {
        _feedbackMessage =
            'Very Good: But oversleeping might cause grogginess and other issues.';
        _effectsMessage =
            'Effects: Oversleeping can cause headaches, back pain, and increased risk of chronic diseases.';
      }
    });
  }

  Future<void> _logSleepHours() async {
    if (_hoursController.text.isEmpty) return;

    final hours = double.tryParse(_hoursController.text) ?? 0.0;
    await _dbHelper.insertLog({
      'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'hours': hours,
    });

    _hoursController.clear();
    _calculateSleepFeedback(hours);
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
            Text(
              _feedbackMessage,
              style: TextStyle(
                fontSize: 18,
                color: _feedbackColor(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              _effectsMessage,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _hoursController,
              decoration: InputDecoration(labelText: 'Enter hours of sleep'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _logSleepHours,
              child: Text('Log Sleep and Calculate'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _dbHelper.getLogs(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No sleep logs yet.'));
                  } else {
                    var logs = snapshot.data!;
                    return ListView.builder(
                      itemCount: logs.length,
                      itemBuilder: (context, index) {
                        var log = logs[index];
                        return ListTile(
                          title: Text('Date: ${log['date']}'),
                          subtitle: Text('Hours: ${log['hours']}'),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _feedbackColor() {
    if (_feedbackMessage.startsWith('Very Poor')) {
      return Colors.red;
    } else if (_feedbackMessage.startsWith('Poor')) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }
}
