import 'dart:convert';
import 'package:easy_extension/easy_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 로그인 api 호출
  void _onFechedApi() async {
    final String authUrl =
        "https://daelim-server.fleecy.dev/functions/v1/auth"; // authUrl 설정 필요
    final response = await http.post(
      Uri.parse(authUrl),
      body: jsonEncode({
        'email': '202030510@daelim.ac.kr', // 여기에 사용자의 이메일을 입력하세요.
        'password': '202030510', // 여기에 사용자의 비밀번호를 입력하세요.
      }),
      headers: {
        'Content-Type': 'application/json', // 요청의 Content-Type을 설정
      },
    );

    if (response.statusCode == 200) {
      // 응답이 성공적인 경우
      print('Success: ${response.body}');
    } else {
      // 응답이 실패한 경우
      print('Failed: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          double.infinity.widthBox,
          20.heightBox,
          Text(
            "Hello dear..",
            style: GoogleFonts.handjet(fontSize: 28),
          ),
          Text("Get your hands on the legendary sword!",style: GoogleFonts.handjet(fontSize: 16),)
        ],
      )),
    );
  }
}



// import 'dart:convert';

// import 'package:easy_extension/easy_extension.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/config.dart';
// // ignore: unused_import
// import 'package:http/http.dart' as http;

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
// // 로그인 api 호출



//  void _onFechedApi() async {
//     final response = await http.post(
//       Uri.parse(authUrl),
//       body: jsonEncode({
//         'email': '202030510@daelim.ac.kr', // 여기에 사용자의 이메일을 입력하세요.
//         'password': '1234', // 여기에 사용자의 비밀번호를 입력하세요.
//       }),
//       headers: {
//         'Content-Type': 'application/json', // 요청의 Content-Type을 설정
//       },
//     );


//   // log 제대로 안불러와짐
//   // Log.green({
//   //   'status': response.statusCode,
//   //   ''
//   // })

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }


