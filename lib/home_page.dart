import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _toDoList = [
    {'task': 'Meditate for 10 minutes', 'isDone': false},
    {'task': 'Drink a glass of water', 'isDone': false},
    {'task': 'Read a book for 30 minutes', 'isDone': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Morning Starter'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Quote of the Day:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '"The best way to predict the future is to invent it." - Alan Kay',
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'To-Do List:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _toDoList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: IconButton(
                      icon: Icon(
                        _toDoList[index]['isDone']
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: Colors.purple,
                      ),
                      onPressed: () {
                        setState(() {
                          _toDoList[index]['isDone'] =
                              !_toDoList[index]['isDone'];
                        });
                      },
                    ),
                    title: Text(_toDoList[index]['task']),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                'Weather Info:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.wb_sunny, size: 40, color: Colors.orange),
                  SizedBox(width: 10),
                  Text(
                    '25°C, Sunny',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Motivational Quote:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '"Don\'t watch the clock; do what it does. Keep going." - Sam Levenson',
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
