import 'package:flutter/material.dart';
import 'package:flutter_app/src/manageState.dart';
import 'package:flutter_app/src/signup.dart';

import 'data.dart';
import 'select.dart';

import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'dart:io';

class loginPage extends StatelessWidget {
  Widget build(BuildContext context) {
    //현재 페이지에서 요구되는 데이터는 각각 username, password이므로 이를
    //텍스트필드 컨트롤러 변수로 선언하여 받아올 수 있도록 지정

    TextEditingController userName = TextEditingController();
    TextEditingController passWord = TextEditingController();
    final Color maincolor = Color(0xffff7f41);

    HttpOverrides.global = new MyHttpOverrides();

    // 어플 실행 시 인터넷 되는지 확인하고,
    // 인터넷 안되면 자동으로 저장된 데이터 사용해야 함 (TODO)
    int a = 0;

    if (a == 0) {
      Manage.getUser();
      Content.loadMetaFromString(Manage.userVal());
      Manage.getDownload();
      Content.loadDownloadFromString(Manage.downloadVal());
      a++;
    }
    ;

    /*
  빌드 부분
    
  */

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.grey[700]),
      home: Scaffold(
        //기본적인 틀을 위한 컨테이너 생성
        body: Container(
          color: const Color(0xffffffff),
          width: 500,
          height: 812,
          //내부 구성을 배치하기 위해 컬럼 child선언
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //아이콘들이 들어가기 위한 공간 선언
                Container(
                  width: 235,
                  height: 187,
                  margin: const EdgeInsets.only(
                    top: 126,
                  ),
                  child: Image.asset('image/login_image.png'),
                ),
                //첫번째 텍스트 라인
                //두번째 텍스트 라인
                Text.rich(TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: 'Earn',
                    style: TextStyle(
                        color: const Color(0xffffc12f),
                        fontWeight: FontWeight.bold,
                        fontFamily: "MaiandraGD",
                        fontStyle: FontStyle.normal,
                        fontSize: 65.0),
                  ),
                  TextSpan(
                    text: 'du',
                    style: TextStyle(
                        color: const Color(0xffff7f41),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MaiandraGD',
                        fontStyle: FontStyle.normal,
                        fontSize: 65.0),
                  ),
                ])),
                /*
    */
                //아이디 텍스트필드를 만들기 위한 컨테이너 선언
                Container(
                  //디자인에 맞는 크기 지정
                  width: 241,
                  height: 46,
                  /*
                컨테이너 내부의 위젯 격차와 아래 위젯간의 격차를 맞추기위해
                padding과 margin 지정
                */
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  //boxdecoration을 통해 모서리를 둥글게 만들고 음영 추가
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 0.6,
                            spreadRadius: 0)
                      ],
                      //컨테이너의 색은 흰색으로 지정
                      color: const Color(0xffffffff)),
                  //컨테이너에 들어갈 텍스트필드 선언
                  child: TextField(
                    //cursorColor: const Color(0xffff7f41),
                    controller: userName,
                    //아이디는 자동완성기능 추가
                    autocorrect: true,
                    //텍스트 필드 내부의 디자인을 input decoration으로 지정
                    decoration: InputDecoration(
                      //유저이름을 입력할 수 있도록 안내하는 hintText
                      hintText: 'Username',
                      //아이콘 선언을 통해 텍스트 필드에 아이콘이 추가되도록 선언
                      prefixIcon: Icon(Icons.person_outline),
                      //힌트텍스트의 색을 디자인에 맞추어 회색으로 지정
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white70,
                      //외부 테두리 디자인은 부모위젯인 container에 맞추어 지정
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      //글씨쓸때 디자인 또한 부모위젯의 크기에 맞추어 지정
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ),
                /*



              */
                //비밀번호 입력을 위한 컨테이너 지정(아이디 컨테이너와 구성은 같다)
                Container(
                  width: 241,
                  height: 46,
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  margin: const EdgeInsets.symmetric(vertical: 12),
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
                  child: TextField(
                    cursorColor: const Color(0xffff7f41),
                    controller: passWord,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white70,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ),
                /*



              */
                //로그인 단추
                //inkwell 위젯을 통해서 컨테이너를 터치시 동작수행이 가능토록 한다
                InkWell(
                  //내부 구성을 위한 컨테이너
                  child: Container(
                    //위, 아래의 두 위젯간의 거리를 두기 위한 마진
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.symmetric(vertical: 10),

                    //컨테이너의 크기는 버튼의 디자인에 맞게 선언
                    width: 111,
                    height: 46,
                    //boxdecoration을 통해 해당 버튼의 모서리와 형태를 정의
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 6,
                              spreadRadius: 0),
                        ],
                        color: maincolor),
                    //내부엔 텍스트 위젯을 선언 후 디자인에 맞춘 설정
                    child: Text("Log in",
                        style: const TextStyle(
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            fontFamily: "Arial",
                            fontStyle: FontStyle.normal,
                            fontSize: 20.0),
                        textAlign: TextAlign.center),
                  ),
                  //터치시 상호작용의 정의, 현재는 바로 메인페이지로 이동되도록 선언했다.
                  onTap: () {
                    var byte = utf8.encode(passWord.text);
                    String pwdData = sha256.convert(byte).toString();
                    Manage.pwd = pwdData;
                    Student.postRequest(userName.text, pwdData)
                        .then((response) {
                      if (response['status_code'] == 200) {
                        Map data = response['data'];
                        if (Student.username == null) {
                          Student.setUsername(data['user_data']['username']);
                          Student.setFullName(data['user_data']['fullname']);
                          Student.setBirthday(
                              DateTime.parse(data['user_data']['birthday']));
                          Student.setEmail(data['user_data']['email']);
                          Student.setImageId(data['user_data']['image_id']);
                        }

                        Content.originalContent = data['content_list'];
                        Content.originalDownload
                            .addAll(List<Map>.from(data['wish_list']));

                        Content.loadContentFromMap(Content.originalContent);
                        Content.loadDownloadFromMap(Content.originalDownload);
                        print('Total List: ${Content.totalList.length}');
                        print('Download List: ${Content.downloadList.length}');

                        for (Map curriculum in data['curriculum']) {
                          Curriculum.list.add(Curriculum.fromJson(curriculum));
                        }
                        print('Curriculum List: ${Curriculum.list.length}');

                        Content.wishList = [];

                        Manage.setPwd(pwdData);
                        Manage.setTotal(Content.contentToString());
                        Manage.setUser(Content.metaToString());
                        Manage.setDownload(Content.downloadToString());

                        // Manage.getTotal();
                        // Manage.getUser();
                        // Manage.getPwd();

                        //  변환 테스트
                        // print('Start convert');
                        // String str = Content.contentToString();
                        // print('content to str ok');
                        // Content.loadContentFromString(str);
                        // print('str to content ok');
                        // //유저 데이터를 포함해서 wish his down 세가지에 저장 및 로드
                        // str = Content.metaToString();
                        // Provider.of<manage>(context, listen: false)
                        //     .setTotal(Content.metaToString());
                        // print('meta to str ok');
                        // Content.loadMetaFromString(str);
                        // print('str to meta ok');
                        // print('Convert successful');

                        // 뒤로가기 눌렀을 때 다시 로그인창 뜨지 않도록
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => selectPage()));
                      } else {
                        String checkTotal = Manage.totalVal();
                        String checkData = Manage.userVal();
                        Content.loadContentFromString(checkTotal);
                        Content.loadContentFromString(checkData);
                        String checkPwd = Manage.pwdVal();
                        if (Student.username == userName.toString() &&
                            pwdData == checkPwd) {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => selectPage()));
                        } else
                          FlutterDialog(context);
                      }
                    }).catchError((error) {
                      print(error);
                      FlutterDialog(context);
                    });
                  },
                ),
                /*



               */
                //signup페이지로 이동하기 위한 버튼
                //inkwell을 통해 일반 컨테이너도 버튼처럼 상호작용이 가능하토록 함
                InkWell(
                  //내부 구성으로는 컨테이너 그리고 그 안에 텍스트가 들어가 있는 형식

                  child: Container(
                    //가로, 세로, 마진, 패딩을 각각 디자인 양식에 맞춰 지정
                    margin: const EdgeInsets.all(7),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    width: 111,
                    height: 46,
                    //컨테이너의 디자인은 제시된 이미지에 맞게 지정
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 6,
                              spreadRadius: 0)
                        ],
                        color: maincolor),
                    //텍스트는 signup, 나머지 양식은 디자인에 맞춤
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => signUp()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
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
                  "ID or Password error",
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
