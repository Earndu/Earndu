import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'sub_widget/myPageWidget.dart';
import 'package:flutter_app/src/manageState.dart';
import 'data.dart';

import 'dart:convert';
import 'package:crypto/crypto.dart';

class myPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _myPage();
}

class _myPage extends State<myPage> {
  @override

  //파이차트에 들어갈 각 과목의 퍼센테이지
  double history;
  double math;
  double science;
  double health;
  double sports;

  //학습 시간에 대한 값을 가져오는 변수

  Map<int, int> WeeklyStudytime = {0: 2, 1: 10, 2: 3, 3: 7, 4: 2, 5: 8, 6: 10};
  Map<int, int> MontlyStudytime = {
    0: 2,
    1: 10,
    2: 3,
    3: 7,
    4: 2,
    5: 8,
    6: 10,
    7: 3,
    8: 13,
    9: 6,
    10: 10,
    11: 3,
    12: 7,
    13: 2,
    14: 8,
    15: 10,
    16: 3,
    17: 13,
    18: 6,
    19: 10,
    20: 3,
    21: 7,
    22: 2,
    23: 8,
    24: 10,
    25: 3,
    26: 13,
    27: 6,
    28: 10
  };
  Map<int, int> yearStudytime = {
    0: 2,
    7: 3,
    20: 14,
    25: 3,
    26: 13,
    27: 6,
    28: 10,
    42: 3,
    63: 13,
    83: 6,
    96: 10,
    112: 2,
    7: 3,
    20: 14,
    25: 3,
    26: 13,
  };

  Map<int, int> WholeData = {1: 1};

  List<int> subVal = [40, 30, 20, 20, 15];

  String userName = "";
  int cnt = 0;
  int touchedIndex;
  //이미지랑 아이콘 둘 중 하나를 쓰기 위한 페이지
  String setImage() {
    String result;
    if (Student.imagedata == 0) {
      result = 'image/Elephant_1.png';
    } else if (Student.imagedata == 1) {
      result = 'image/Flamingo_1.png';
    } else if (Student.imagedata == 2) {
      result = 'image/Giraffe_1.png';
    } else if (Student.imagedata == 3) {
      result = 'image/Hippo_1.png';
    } else {
      result = 'image/Koala_1.png';
    }
    return result;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 6),
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(setImage()),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x29000000),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                                spreadRadius: 0),
                          ],
                          color: const Color(0xffff7f41)),
                    ),
                  ),
                  Positioned(
                      top: 15,
                      right: 15,
                      child: IconButton(
                          icon: const Icon(Icons.replay),
                          iconSize: 40,
                          color: const Color(0xffffc12f),
                          onPressed: () {
                            Student.postRequest(Student.username, Manage.pwd)
                                .then((response) {
                              if (response['status_code'] == 200) {
                                Map data = response['data'];
                                if (Student.username == null) {
                                  Student.setUsername(
                                      data['user_data']['username']);
                                  Student.setFullName(
                                      data['user_data']['fullname']);
                                  Student.setBirthday(DateTime.parse(
                                      data['user_data']['birthday']));
                                  Student.setEmail(data['user_data']['email']);
                                  Student.setImageId(
                                      data['user_data']['image_id']);
                                }

                                Content.originalContent = data['content_list'];
                                Content.originalDownload
                                    .addAll(List<Map>.from(data['wish_list']));

                                Content.loadContentFromMap(
                                    Content.originalContent);
                                Content.loadDownloadFromMap(
                                    Content.originalDownload);
                                print(
                                    'Total List: ${Content.totalList.length}');
                                print(
                                    'Download List: ${Content.downloadList.length}');

                                for (Map curriculum in data['curriculum']) {
                                  Curriculum.list
                                      .add(Curriculum.fromJson(curriculum));
                                }
                                print(
                                    'Curriculum List: ${Curriculum.list.length}');

                                Content.wishList = [];

                                Manage.setPwd(Manage.pwdVal());
                                Manage.setTotal(Content.contentToString());
                                Manage.setUser(Content.metaToString());
                                Manage.setDownload(Content.downloadToString());
                              }
                            });
                          }))
                ],
              ),
              Center(
                child: Text("${Student.username}",
                    style: const TextStyle(
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w700,
                        fontFamily: "SegoeUI",
                        fontStyle: FontStyle.normal,
                        fontSize: 20.0),
                    textAlign: TextAlign.left),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 49),
                margin: const EdgeInsets.symmetric(vertical: 17),
                height: 25,
                alignment: Alignment.centerLeft,
                child: Text("Learning Status",
                    style: const TextStyle(
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w700,
                        fontFamily: "SegoeUI",
                        fontStyle: FontStyle.normal,
                        fontSize: 20.0),
                    textAlign: TextAlign.left),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: InkWell(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          width: 67,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0x29000000),
                                    offset: Offset(0, 3),
                                    blurRadius: 6,
                                    spreadRadius: 0)
                              ],
                              color: const Color(0xffffc12f)),
                          child: Center(
                            child: Text("week",
                                style: const TextStyle(
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.0),
                                textAlign: TextAlign.left),
                          ),
                        ),
                        //상태변화 정의
                        onTap: () {
                          setState(() {
                            cnt = 0;
                            WholeData = WeeklyStudytime;
                          });
                        },
                      ),
                    ),
                    Container(
                      child: InkWell(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          width: 80,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0x29000000),
                                    offset: Offset(0, 3),
                                    blurRadius: 6,
                                    spreadRadius: 0)
                              ],
                              color: const Color(0xffffc12f)),
                          child: Center(
                            child: Text("Month",
                                style: const TextStyle(
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.0),
                                textAlign: TextAlign.left),
                          ),
                        ),
                        //상태 변화 정의
                        onTap: () {
                          setState(() {
                            cnt = 1;
                            WholeData = MontlyStudytime;
                          });
                        },
                      ),
                    ),
                    Container(
                      child: InkWell(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          width: 67,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0x29000000),
                                    offset: Offset(0, 3),
                                    blurRadius: 6,
                                    spreadRadius: 0)
                              ],
                              color: const Color(0xffffc12f)),
                          child: Center(
                            child: Text("Year",
                                style: const TextStyle(
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.0),
                                textAlign: TextAlign.left),
                          ),
                        ),
                        //상태변화 정의
                        onTap: () {
                          setState(() {
                            cnt = 2;
                            WholeData = yearStudytime;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Stack(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.70,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 18.0, left: 12.0, top: 24, bottom: 12),
                          child: LineChart(
                            mainData(cnt, WholeData),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 170,
                margin: const EdgeInsets.only(top: 10),
                child: AspectRatio(
                  aspectRatio: 1.4,
                  child: Card(
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          height: 18,
                        ),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: PieChart(
                              PieChartData(
                                  pieTouchData: PieTouchData(
                                      touchCallback: (pieTouchResponse) {
                                    setState(() {
                                      if (pieTouchResponse.touchInput
                                              is FlLongPressEnd ||
                                          pieTouchResponse.touchInput
                                              is FlPanEnd) {
                                        touchedIndex = -1;
                                      } else {
                                        touchedIndex = pieTouchResponse
                                            .touchedSectionIndex;
                                      }
                                    });
                                  }),
                                  borderData: FlBorderData(
                                      show: true,
                                      border: Border.all(
                                        color: Color(0xffffffff),
                                        width: 20,
                                        style: BorderStyle.none,
                                      )),
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 30,
                                  sections:
                                      showingSections(touchedIndex, subVal)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
