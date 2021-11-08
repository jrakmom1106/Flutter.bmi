import 'package:bmi/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //키 추가
  final TextEditingController _emailController = TextEditingController(); //입력되는 값을 제어 , 검증
  final TextEditingController _passwordController = TextEditingController();

  Widget _emailWidget(){
    return TextFormField(

      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: '이메일',

      ),

      validator: (String? value){
        if (value!.isEmpty){ // == null isEmpty-> !.isEmpty
          return '이메일을 입력해 주세요';
        }
        return null;
      },

      onChanged: (value){
        setState(() {

        });
      },
    );
  }
  Widget _passwordWidget(){
    return TextFormField(

      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: '패스워드',

      ),

      validator: (String? value){
        if (value!.isEmpty){ // == null isEmpty-> !.isEmpty
          return ' 패스워드를 입력해 주세요';
        }
        return null;
      },

      onChanged: (value){
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
    super.dispose();
  }


  _login() async {
    //키보드 숨기기
    FocusScope.of(context).requestFocus(FocusNode());
    //사용자 등록 > firebase, user registration
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

    }on FirebaseAuthException catch (e){
      logger.e(e);

    }
  }
}