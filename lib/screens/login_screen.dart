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
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

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

// 패스워드 재설정
  void _onRecoveryPassword() {}

// 로그인 버튼
  void _onSignIn() {}

  // 타이틀 텍스트 위젯
  List<Widget> _buildTitleText() => [
        Text(
          "Hello zelda..",
          style: GoogleFonts.handjet(fontSize: 28),
        ),
        10.heightBox,
        Text(
          "Get your hands on the \n legendary sword!",
          style: GoogleFonts.handjet(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ];

  // 텍스트 입력 위젯들
  List<Widget> _buildTextFields() => [
        _buildTextField(
          controller: _emailController,
          hintText: "E-mail",
        ),
        _buildTextField(
            controller: _pwController, hintText: "Passwod", obscure: true)
      ];

  // 입력폼 위젯
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool? obscure,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          fillColor: Color(0xFF63947D),
          // border: ,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          suffix: obscure != null
              ? Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                )
              : null),
      obscureText: obscure ?? false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd0f8b7),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            30.heightBox,
            ..._buildTitleText(),
            35.heightBox,
            ..._buildTextFields(),

            30.heightBox,
            // recovery password
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // 버튼을 오른쪽으로 정렬
              children: [
                TextButton(
                  onPressed: _onRecoveryPassword,
                  child: Text(
                    "recovery password",
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                ),
              ],
            ),

            //
            // Align(
            //   alignment: Alignment.centerRight,
            // ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onSignIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff31604a),
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),

                  // textStyle: GoogleFonts.poppins(color: colors),
                ),
                child: Text(
                  "link on",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
            ),

            40.heightBox,

            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.grey.withOpacity(0.8), // 불투명도를 높임
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'or continue with',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.grey.withOpacity(0.8), // 불투명도를 높임
                          Colors.transparent,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
              ],
            )
            
          ],
        ),
      )),
    );
  }
}
