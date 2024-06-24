import 'package:flutter/material.dart';
import 'database_helper.dart';

class ProfilePage extends StatelessWidget {
  final String email;

  ProfilePage({required this.email});

  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<Map<String, dynamic>?> _fetchProfile() async {
    return await _dbHelper.getUserProfile(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No profile data available.'));
          } else {
            var user = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user['profilePictureUrl'] ??
                          'https://via.placeholder.com/150'),
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text('Name',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle:
                          Text(user['name'], style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text('Email',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle:
                          Text(user['email'], style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text('Age',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(user['age'].toString(),
                          style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
