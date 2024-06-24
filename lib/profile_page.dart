import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatelessWidget {
  final String email;

  ProfilePage({required this.email});

  Future<Map<String, dynamic>> _fetchProfile() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/profile/$email'));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            var user = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Name: ${user['name']}', style: TextStyle(fontSize: 20)),
                  Text('Email: ${user['email']}',
                      style: TextStyle(fontSize: 20)),
                  Text('Age: ${user['age']}', style: TextStyle(fontSize: 20)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
