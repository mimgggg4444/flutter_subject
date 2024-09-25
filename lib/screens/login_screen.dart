import 'dart:convert';
import 'package:easy_extension/easy_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/config.dart';

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
  void _onFetchedApi() async {

// 이메일과 비밀번호를 텍스트 컨트롤러에서 가져옴
final email = _emailController.text; 
final password = _pwController.text; 

// 로그인 데이터 생성
final loginData = {
  'email': email, 
  'password': password,
};



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

  void _onSignIn() async {
    // 이메일과 비밀번호를 텍스트 컨트롤러에서 가져옴
    final email = _emailController.text; 
    final password = _pwController.text; 

    // 로그인 데이터 생성
    final loginData = {
      'email': email, 
      'password': password,
    };

    // API 요청 URL을 configurer.dart에서 가져옴
    try {
      final response = await http.post(
        Uri.parse(authUrl), // configurer.dart에서 가져온 authUrl 사용
        body: jsonEncode(loginData),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // 성공적으로 로그인한 경우
        print('Success: ${response.body}');
        // 추가적인 처리 (예: 홈 화면으로 이동)
      } else {
        // 로그인 실패한 경우
        print('Failed: ${response.statusCode}');
        // SnackBar로 에러 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('로그인 실패: ${response.statusCode}')),
        );
      }
    } catch (error) {
      print('Error: $error');
      // SnackBar로 에러 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 중 오류 발생: $error')),
      );
    }
  }


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
            ),

            20.heightBox, // 여백 추가

// 구글, 애플, 깃허브 아이콘 추가 (이미지 네트워크 사용)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('준비중인 기능입니다!')),
                    );
                  },
                  child: Image.network(
                    'https://daelim-server.fleecy.dev/storage/v1/object/public/icons/google.png',
                    height: 50,
                  ),
                ),
                20.widthBox, // 아이콘 간격
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('준비중인 기능입니다!')),
                    );
                  },
                  child: Image.network(
                    'https://daelim-server.fleecy.dev/storage/v1/object/public/icons/apple.png',
                    height: 50,
                  ),
                ),
                20.widthBox, // 아이콘 간격
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('준비중인 기능입니다!')),
                    );
                  },
                  child: Image.network(
                    'https://daelim-server.fleecy.dev/storage/v1/object/public/icons/github.png',
                    height: 50,
                  ),
                ),
              ],
            ),

            40.heightBox, // 여백 추가

// "Not a member? Register now" 추가
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member? ",
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                GestureDetector(
                  onTap: () {
                    // Register now 클릭 시 동작할 코드
                    print('Register now clicked!');
                  },
                  child: Text(
                    "Register now",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.blue, // 링크처럼 보이게 파란색으로 설정
                    ),
                  ),
                ),
              ],
            ),
            30.heightBox, // 여백 추가
          ],
        ),
      )),
    );
  }
}


// singlechildscrollview
// color theme of context texttheme bodymedium?.color

// context.theme.textTheme.bodymidum
// asdf


// 버튼 눌렀을때 snackbar 나올 수 있게 하기 ontap 사용해서