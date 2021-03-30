//통신쪽 패키지
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

//위젯구성 패키지
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_date_textbox/cupertino_date_textbox.dart';
import 'package:flutter_app/src/selectImage.dart';
import 'package:intl/intl.dart';

import 'selectImage.dart';
import 'package:crypto/crypto.dart';
import 'data.dart';

class signUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          cursorColor: Colors.grey,
          primaryColor: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        //머티리얼 앱의 스캐폴드 타입으로 정의
        home: signUp_stateful());
  }
}

class signUp_stateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _signUp_stateful();
}

class _signUp_stateful extends State<signUp_stateful> {
  Image imageFile = Image.asset(
    'image/Elephant_1.png',
    fit: BoxFit.fill,
  );
  TextEditingController userName = TextEditingController();
  TextEditingController passWord = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController eMail = TextEditingController();
  DateTime _selectedDateTime = DateTime.now();
  void onBirthdayChange(DateTime birthday) {
    setState(() {
      _selectedDateTime = birthday;
    });
  }

  int image_id = 0;
  @override
  Widget build(BuildContext context) {
    //시간을 갱신하기 위한 함수 setState를 사용하였다.

//각각의 텍스트를확인할 때는 userName.text처럼 값을 가져올 수 있다.

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        color: const Color(0xffffffff),
        child: SingleChildScrollView(
          /*
                


            */
          //Earndu 글씨
          child: Column(
            children: <Widget>[
              //첫번째로 들어가는 텍스트 Earndu
              Container(
                //center로 구성되어 있기 때문에 위아래 마진만 조절
                margin: const EdgeInsets.only(top: 23, bottom: 12),
                //자식 위젯은 텍스트, 전체적인 디자인은 zeplin에서 제공하는 형태에 맞춤
                child: Text.rich(TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: 'Earn',
                    style: TextStyle(
                        color: const Color(0xffffc12f),
                        fontWeight: FontWeight.bold,
                        fontFamily: "MaiandraGD",
                        fontStyle: FontStyle.normal,
                        fontSize: 46.0),
                  ),
                  TextSpan(
                    text: 'du',
                    style: TextStyle(
                        color: const Color(0xffff7f41),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MaiandraGD',
                        fontStyle: FontStyle.normal,
                        fontSize: 45.0),
                  ),
                ])),
              ),
/*



 */

              InkWell(
                //사진이 들어갈 컨테이너
                child: Container(
                  margin: const EdgeInsets.only(top: 0, bottom: 20),
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                            spreadRadius: 0)
                      ],
                      color: const Color(0xffff7f41)),
                  child: ClipOval(child: imageFile),
                ),
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => selectImage()),
                  );
                  setState(() {
                    if (result == 'image/Elephant_1.png') {
                      image_id = 0;
                    } else if (result == 'image/Flamingo_1.png') {
                      image_id = 1;
                    } else if (result == 'image/Giraffe_1.png') {
                      image_id = 2;
                    } else if (result == 'image/Hippo_1.png') {
                      image_id = 3;
                    } else if (result == 'image/Koala_1.png') {
                      image_id = 4;
                    }
                    imageFile = Image.asset(
                      result,
                      fit: BoxFit.fill,
                    );
                  });
                },
              ),

              /*



                */
              //텍스트필드 1을 위한 컨테이너, 여기서는 유저네임이 들어간다.
              Container(
                //전체적인 크기 지정
                width: 281,
                height: 54,
                //위젯간의 거리를 두기 위한 margin설정
                margin: const EdgeInsets.only(bottom: 12),
                //컨테이너의 형태를 잡기 위한 boxdecoration
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                          spreadRadius: 0)
                    ],
                    color: const Color(0xffffffff)),
                //컨테이너 내부의 위젯으로 textfield 지정
                child: TextField(
                  //컨트롤러 설정을 통해 텍스트 필드의 값을 받아온다
                  controller: userName,
                  //내부 설정으 안할 경우 컨테이너 위로 튀어나오기 때문에 설정
                  decoration: InputDecoration(
                    //유저네임을 입력받을 수 있게 안내 설정
                    hintText: 'Username',
                    //인식을 위한 아이콘 설정
                    prefixIcon: Icon(
                      Icons.person_outline,
                      size: 35,
                      color: const Color(0xffbbbbbb),
                    ),
                    //힌트텍스트의 색을 회색으로 지정
                    hintStyle: TextStyle(color: const Color(0xffbbbbbb)),
                    filled: true,
                    fillColor: Colors.white70,
                    //터치되지 않았을 때의 전체적인 경계 지정
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    //터치되었을 때의 전체적인 경계 지정
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ),
              /*
  
  
  
   */
              //텍스트필드 2을 위한 컨테이너, 여기서는 패스워드가 들어간다.
              Container(
                //전체적인 크기 지정
                width: 281,
                height: 54,
                //위젯간의 거리를 두기 위한 margin설정
                margin: const EdgeInsets.symmetric(vertical: 12),
                //컨테이너의 형태를 잡기 위한 boxdecoration
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                          spreadRadius: 0)
                    ],
                    color: const Color(0xffffffff)),
                //컨테이너 내부의 위젯으로 textfield 지정
                child: TextField(
                  obscureText: true,
                  //커서의 색은 회색으로
                  //컨트롤러 설정을 통해 텍스트 필드의 값을 받아온다
                  controller: passWord,
                  //내부 설정을 안할 경우 컨테이너 위로 튀어나오기 때문에 설정
                  decoration: InputDecoration(
                    //유저네임을 입력받을 수 있게 안내 설정
                    hintText: 'Password',
                    //인식을 위한 아이콘 설정
                    prefixIcon: Icon(Icons.lock_outline,
                        size: 35, color: const Color(0xffbbbbbb)),
                    //힌트텍스트의 색을 회색으로 지정
                    hintStyle: TextStyle(color: const Color(0xffbbbbbb)),
                    //터치되지 않았을 때의 전체적인 경계 지정
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    //터치되었을 때의 전체적인 경계 지정
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ),
              /* 



              */
              //컨테이너3 여기는 user의 fullname이 들어간다
              Container(
                //전체적인 크기 지정
                width: 281,
                height: 54,
                //위젯간의 거리를 두기 위한 margin설정
                margin: const EdgeInsets.symmetric(vertical: 12),

                //컨테이너의 형태를 잡기 위한 boxdecoration
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                          spreadRadius: 0)
                    ],
                    color: const Color(0xffffffff)),
                //컨테이너 내부의 위젯으로 textfield 지정
                child: TextField(
                  //커서의 색은 회색으로
                  //컨트롤러 설정을 통해 텍스트 필드의 값을 받아온다
                  controller: fullName,
                  //내부 설정을 안할 경우 컨테이너 위로 튀어나오기 때문에 설정
                  decoration: InputDecoration(
                    //유저네임을 입력받을 수 있게 안내 설정
                    hintText: 'Fullname',
                    //인식을 위한 아이콘 설정
                    prefixIcon: Icon(
                      Icons.person_outline,
                      size: 35,
                      color: const Color(0xffbbbbbb),
                    ),
                    //힌트텍스트의 색을 회색으로 지정
                    hintStyle: TextStyle(color: const Color(0xffbbbbbb)),
                    //터치되지 않았을 때의 전체적인 경계 지정
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    //터치되었을 때의 전체적인 경계 지정
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ),

//컨테이너3 여기는 user의 Email이 들어간다
              Container(
                //전체적인 크기 지정
                width: 281,
                height: 54,
                //위젯간의 거리를 두기 위한 margin설정
                margin: const EdgeInsets.symmetric(vertical: 12),
                //컨테이너의 형태를 잡기 위한 boxdecoration
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                          spreadRadius: 0)
                    ],
                    color: const Color(0xffffffff)),
                //컨테이너 내부의 위젯으로 textfield 지정
                child: TextField(
                  //커서의 색은 회색으로
                  //컨트롤러 설정을 통해 텍스트 필드의 값을 받아온다
                  controller: eMail,
                  //내부 설정을 안할 경우 컨테이너 위로 튀어나오기 때문에 설정
                  decoration: InputDecoration(
                    //유저네임을 입력받을 수 있게 안내 설정
                    hintText: 'Email',
                    //인식을 위한 아이콘 설정
                    prefixIcon: Icon(Icons.mail_outline,
                        size: 35, color: const Color(0xffbbbbbb)),
                    //힌트텍스트의 색을 회색으로 지정
                    hintStyle: TextStyle(color: const Color(0xffbbbbbb)),
                    //터치되지 않았을 때의 전체적인 경계 지정
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    //터치되었을 때의 전체적인 경계 지정
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ),

              Container(
                //전체적인 크기 지정
                width: 281,
                height: 54,
                //위젯간의 거리를 두기 위한 margin설정
                margin: const EdgeInsets.symmetric(vertical: 12),
                //컨테이너의 형태를 잡기 위한 boxdecoration
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 2),
                          blurRadius: 6,
                          spreadRadius: 0)
                    ],
                    color: const Color(0xffffffff)),
                //컨테이너 내부의 위젯으로 textfield 지정
                child: CupertinoDateTextBox(
                  initialValue: _selectedDateTime,
                  hintColor: Colors.grey,
                  onDateChange: onBirthdayChange,
                  hintText: ("Select your birthday"),
                ),
              ),

              InkWell(
                child: Container(
                  width: 111,
                  height: 37,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                            spreadRadius: 0)
                      ],
                      color: const Color(0xffff7f41)),
                  child: Text("Sign up",
                      style: const TextStyle(
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                          fontFamily: "Arial",
                          fontStyle: FontStyle.normal,
                          fontSize: 20.0),
                      textAlign: TextAlign.center),
                ),
                onTap: () {
                  postRequest().then((data) {
                    if (data['status_code'] == 200) {
                      Student.setUsername(userName.text);
                      Student.setFullName(fullName.text);
                      Student.setBirthday(_selectedDateTime);
                      Student.setImageId(image_id);
                      Student.setEmail(eMail.text);

                      Navigator.of(context, rootNavigator: true).pop(context);
                    } else {
                      print(data['message']);
                      FlutterDialog(context);
                    }
                  }).catchError((error) {
                    print(error);
                    FlutterDialog(context);
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Map> postRequest() async {
    var url = 'https://svclaw.ipdisk.co.kr:11003/student';

    String ymd = DateFormat("yyyy-MM-dd").format(_selectedDateTime);
    String pwdData = sha256.convert(utf8.encode(passWord.text)).toString();

    Map Post_data = {
      "username": userName.text, // 로그인에 사용할 아이디
      "password": pwdData, // SHA-256 해싱된 암호
      "fullname": fullName.text, // 이름
      "email": eMail.text, // 이메일
      "birthday": ymd, // 생년월일
      "image_id": image_id
    };
    var body = json.encode(Post_data);
    print(body);

    var rawResponse = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    var response = json.decode(rawResponse.body);

    return response;
  }

  void FlutterDialog(BuildContext context) {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: <Widget>[
                new Text("Error"),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Error occurs during signing up.",
                ),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
