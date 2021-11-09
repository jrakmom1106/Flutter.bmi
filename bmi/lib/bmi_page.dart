
import 'package:bmi/list_page.dart';
import 'package:bmi/user_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:bmi/LoginPage.dart';
import 'package:get/get.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({Key? key}) : super(key: key);

  @override
  _BmiPageState createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {


  final TextEditingController hController = TextEditingController(); //입력되는 값을 제어 , 검증
  final TextEditingController wController = TextEditingController();

  final GlobalKey<FormState> _formKey =GlobalKey<FormState>(); //키 추가

  String _bmi = '0';

  // 0 : 대기 ,1 : 저체중 2: 정상 3. 과체중, 4 : 비만 , 5: 고도비만
  int _bmiStatus = 0;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,   // 하단오류 해결방법 .. 올려도 가려진 부분을 무시
      appBar: AppBar(
        title: Text("BMI 계산기"),
        actions: [

          GestureDetector(
            onTap: () async {
              //사용자 정보보기 ,목록보기 버튼2개
              Get.to(()=> const UserPage());
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.account_circle),
            ),

          ),
          GestureDetector(
            onTap: () async {
              //사용자 정보보기 ,목록보기 버튼2개
              Get.to(()=> const ListPage());
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.article),
            ),

          ),

        ],
      ),

      body: Form(

        key : _formKey,
        child: Padding(

          padding: const EdgeInsets.all(20.0),


          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image(

                    width: 100.0,
                    image: AssetImage(
                        _bmiStatus == 0 ?    'assets/images/smile1.PNG'
                        : _bmiStatus == 1 ? 'assets/images/smile2.PNG'
                            : _bmiStatus ==2 ? 'assets/images/green.PNG'
                            : _bmiStatus ==3 ? 'assets/images/smile3.PNG'
                            : _bmiStatus ==4 ? 'assets/images/yellow.PNG'
                            :_bmiStatus == 5 ? 'assets/images/red.PNG'
                            : 'assets/images/green.PNG'

                    )),

                Center(
                  //UI 작성
                  child: Text("BMI : ${_bmi}",
                    style: const TextStyle(fontSize: 25.0),
                  ), //$ 를 붙이면 변수내용을 화면에 출력
                ),
                const SizedBox(height:10.0,),


                Row(
                  children: <Widget> [
                    Expanded(
                      child: TextFormField(

                        controller: hController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '키(cm)',

                        ),

                        validator: (String? value){
                          if (value!.isEmpty){ // == null isEmpty-> !.isEmpty
                            return '키를 입력해 주세요';
                          }
                          return null;
                        },

                        onChanged: (value){
                          setState(() {

                          });
                        },
                      ),
                    ),

                    const SizedBox(width: 10.0,),
                    Expanded(
                      child: TextFormField(
                        controller: wController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '몸무게(kg)',
                        ),
                        validator: (String? value){
                          if (value!.isEmpty){ // == null isEmpty-> !.isEmpty
                            return '키를 입력해 주세요';
                          }
                          return null;
                        },
                        onChanged: (value){
                          setState(() {

                          });
                        },
                      ),

                    ),
                  ],
                ),
                const SizedBox(height: 20.0,),
                Container(
                  height: 70,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // print('z키 : ${hController.text}, 몸무게 : ${wController.text}' );
                        double h = double.parse(hController.text);
                        double w = double.parse(wController.text);
                        double bmiDouble = (w / ((h / 100) * (h / 100)));
                        String bmi = (bmiDouble).toStringAsFixed(2);

                        int bmiStatus = 0;

                        if(bmiDouble < 18) {
                          bmiStatus = 1;
                          bmi = '저체중($bmi)';
                        } else if (bmiDouble >= 18 && bmiDouble < 23){
                          bmiStatus = 2;
                          bmi = '정상($bmi)';
                        } else if (bmiDouble >= 23 && bmiDouble < 25){
                          bmiStatus = 3;
                          bmi = '과체중($bmi)';
                        } else if (bmiDouble >= 25 && bmiDouble < 30){
                          bmiStatus = 4;
                          bmi = '비만($bmi)';
                        } else if (bmiDouble >= 30){
                          bmiStatus = 5;
                          bmi = '고도비만($bmi)';
                        }

                        setState(() {
                          _bmi = bmi;
                          _bmiStatus = bmiStatus;
                        });
                      }

                    },
                    child: const Text('BMI 계산하기'),
                  ),
                ),



              ],

            ),

          ),
        ),

      ),


      /*
      bottomNavigationBar: Container(
        height: 50,
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            onPressed: (){},
            child: const Text('BMI 계산기'),

        ),

      ),
    */



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

}