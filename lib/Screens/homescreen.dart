import 'package:flutter/material.dart';
import 'package:tracking/Providers/login_provider.dart'; // Import LoginProvider untuk mengakses data sopir yang login

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ambil data sopir yang login dari LoginProvider
    final loggedInSopir = LoginProvider.loggedInSopir;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Sopir Info',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            // Tampilkan informasi sopir
            Text('Name: ${loggedInSopir?.nama_sopir ?? "Unknown"}'),
            Text('Email: ${loggedInSopir?.email ?? "Unknown"}'),
            // Tambahkan informasi lainnya sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}
