
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:bmi/bmi_page.dart';
import 'package:bmi/main.dart';
import 'package:bmi/joinPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //키 추가
  final TextEditingController _emailController = TextEditingController(); //입력되는 값을 제어 , 검증
  final TextEditingController _passwordController = TextEditingController();

  Widget _emailWidget() {
    return TextFormField(

      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: '이메일',

      ),

      validator: (String? value) {
        if (value!.isEmpty) { // == null isEmpty-> !.isEmpty
          return '이메일을 입력해 주세요';
        }
        return null;
      },

      onChanged: (value) {
        setState(() {

        });
      },
    );
  }

  Widget _passwordWidget() {
    return TextFormField(

      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: '패스워드',

      ),

      validator: (String? value) {
        if (value!.isEmpty) { // == null isEmpty-> !.isEmpty
          return ' 패스워드를 입력해 주세요';
        }
        return null;
      },

      onChanged: (value) {
        setState(() {

        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // 하단오류 해결방법 .. 올려도 가려진 부분을 무시
      appBar: AppBar(
        title: Text("로그인"),
      ),

      body: Form(

        key: _formKey,
        child: Padding(

          padding: const EdgeInsets.all(20.0),


          child: Column(
            children: [
              _emailWidget(),
              const SizedBox(
                height: 10.0,
                width: 10.0,),

              _passwordWidget(),
              const SizedBox(width: 10.0,),
              Container(
                height: 70,
                width: double.infinity,
                padding: EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () => _login(),
                  child: const Text('로그인'),
                ),
              ),
              //회원가입버튼만들기
              const SizedBox(height:20.0),
              GestureDetector(
                child: const Text(' 회원가입') ,
                onTap: (){
                  Get.to(()=> const JoinPage());
                }
              )



            ],


          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    //해당 클래스가 호출되었을떄
    super.initState();
  }

  @override
  void dispose() {
    // 해당 클래스가 사라질떄

    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }


  _login() async {
    if (_formKey.currentState!.validate()) {
      //키보드 숨기기
      FocusScope.of(context).requestFocus(FocusNode());
      //사용자 등록 > firebase, user registration
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        Get.offAll(() => const BmiPage());
      } on FirebaseAuthException catch (e) {
        logger.e(e);
        //값에 따라서 안내메시지 출력
        String message = '';

        if (e.code == 'user-not-found') {
          message = '사용자가 존재하지 않습니다';
        } else if (e.code == 'wrong-password') {
          message = '비밀번호를 확인하세요';
        } else if (e.code == 'invalid-email') {
          message = '올바른 형식의 이메일을 입력해주세요';
        }
        /*
      final snackBar = SnackBar(
          content: Text(message),
        backgroundColor: Colors.deepOrange,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
*/
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Colors.deepOrange,
        ),
        );
      }
    }
  }
}