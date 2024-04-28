import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking/Models/sopir.dart'; // Import model Sopir
import 'package:tracking/Screens/homescreen.dart'; // Import halaman baru

class LoginProvider {
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController =
      TextEditingController();
  static Sopir? loggedInSopir; // Simpan data sopir yang login di sini

static Future<void> login(BuildContext context) async {
    final String apiUrl = 'http://localhost:8000/api/login/sopir';
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      // Pastikan responseData adalah Map (JSON)
      if (responseData is Map) {
        String? token = responseData['token'];
        if (token != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          print('Token : ${token}');

          // Ambil ID sopir dari respons API (jika ada)
          final Id = responseData['id'];
          if (Id != null) {
            // Kirim permintaan untuk mendapatkan data sopir berdasarkan ID
            final sopirResponse = await http.get(
              Uri.parse('http://localhost:8000/api/sopir/$Id'),
              headers: {
                'Authorization':
                    'Bearer $token', // Jika perlu token untuk otentikasi
              },
            );

            if (sopirResponse.statusCode == 200) {
              final sopirData = json.decode(sopirResponse.body);
              loggedInSopir = Sopir.fromJson(sopirData);
              // Navigasi ke halaman baru hanya jika ID sopir tidak null
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            } else {
              print(
                  'Gagal mendapatkan data sopir. Kode status: ${sopirResponse.statusCode}');
            }
          } else {
            print('ID sopir tidak tersedia dalam respons API.');
          }
        } else {
          print('Token tidak tersedia dalam respons API.');
        }
      } else {
        print('Respons tidak berupa JSON.');
      }
    } else {
      print('Gagal melakukan login. Kode status: ${response.statusCode}');
    }
  }

}
