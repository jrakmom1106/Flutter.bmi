import 'package:bmi/LoginPage.dart';
import 'package:bmi/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({Key? key}) : super(key: key);

  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //키 추가
  final TextEditingController _emailController = TextEditingController(); //입력되는 값을 제어 , 검증
  final TextEditingController _passwordController = TextEditingController();

  //이름 이메일 비밀번호 추가.
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  Widget _nameWidget() {
    return TextFormField(

      controller: _nameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: '이름',

      ),

      validator: (String? value) {
        if (value!.isEmpty) { // == null isEmpty-> !.isEmpty
          return '이름을 입력해 주세요';
        }
        return null;
      },

      onChanged: (value) {
        setState(() {

        });
      },
    );
  }

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
  Widget _password2Widget() {
    return TextFormField(

      controller: _password2Controller,
      obscureText: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: '비밀번호 확인',

      ),

      validator: (String? value) {
        if (value!.isEmpty) { // == null isEmpty-> !.isEmpty
          return ' 비밀번호 확인을 입력해 주세요';
        } else if(value != _passwordController.text){
          return '비밀번호와 비밀번호 확인이 다릅니다.';
        }
        return null;
      },

      onChanged: (value) {
        setState(() {

        });
      },
    );
  }

  Widget _joinButtonWidget(){
    return Container(
      height: 70,
      width: double.infinity,
      padding: EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        onPressed: () => _join(),
        child: const Text('회원가입'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child : Column(
                children: [
                  const SizedBox(height: 20.0,),
                  _nameWidget(),
                  const SizedBox(height: 20.0,),
                  _emailWidget(),
                  const SizedBox(height: 20.0,),
                  _passwordWidget(),
                  const SizedBox(height: 20.0,),
                  _password2Widget(),

                  _joinButtonWidget(),


                ],
              )
            ),
          ),
        ),
      )
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _password2Controller.dispose();

    super.dispose();
  }



  Future<void> _join() async {
  //formKey 검사

    if (_formKey.currentState!.validate()){
      FocusScope.of(context).requestFocus(FocusNode()); //키보드 숨기기

      //사용자 정보를 등록


      try{
      //사용자 등록
        final User? user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email:  _emailController.text,
          password: _passwordController.text
        )).user; // user에 사용자등록을 했다.
        // 파이어스토어에 넣는다.
        CollectionReference userCollection = FirebaseFirestore.instance.collection('user'); //연결준비
        userCollection.doc(user!.uid).set({
          'name' : _nameController.text,

        }).then((value) async {
          //회원가입을하면 토큰이 바로 발급되서 바로 로그인이 된다 이를 다르게 한다
          await FirebaseAuth.instance.signOut();
          Get.offAll(() => const LoginPage());
        }).catchError((e) async {
       logger.e(e);
       //사용자 지우기
       await FirebaseAuth.instance.currentUser!.delete();
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(e),
    backgroundColor: Colors.deepOrange,
    ),
    );
    }); //스냅바로 로그를 보여준다.


      } on FirebaseAuthException catch (e){
        logger.e(e);
        String message = '';

        if (e.code == 'weak-password') { //에러코드 핸들링
          message = '비밀번호는 6자리 이상으로 해주세요';
        } else if (e.code == 'email-already-in-use') {
          message = '이미 사용중인 이메일 입니다.';
        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Colors.deepOrange,
        ),
        );

      }

    }





  }

}