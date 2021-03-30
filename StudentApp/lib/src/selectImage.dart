import 'package:flutter/material.dart';

class selectImage extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      //디버깅 텍 제거
      debugShowCheckedModeBanner: false,
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      home: Scaffold(
        body: Center(
          //컨텐츠들의 전체적인 구성은 column타입으로 지정할 것
          child: Column(
            children: <Widget>[
              //이미지 선택 관련 텍스트 출력을 위한 컨테이너
              Container(
                //형식에 맞게 마진 지정
                margin: const EdgeInsets.only(top: 54, bottom: 38),
                child: Text(
                  "choose your character",
                  style: const TextStyle(
                    color: const Color(0xffff7f41),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Arial",
                    fontStyle: FontStyle.normal,
                    fontSize: 25.0,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: const Color(0x29000000),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              //코끼리 이미지가 들어갈 컨테이너
              Container(
                height: 180,
                width: 180,
                margin: const EdgeInsets.only(
                    top: 0, bottom: 20, left: 3, right: 3),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('image/Elephant_1.png'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                          spreadRadius: 0)
                    ],
                    color: const Color(0xffff7f41)),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context, 'image/Elephant_1.png');
                  },
                ),
              ),
              //이후의 컨테이너들은 전부 row타입으로 변경하여 내부 요소로 삽입
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 180,
                    width: 180,
                    margin: const EdgeInsets.only(
                        top: 0, bottom: 20, left: 3, right: 3),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('image/Flamingo_1.png'),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 6,
                              spreadRadius: 0)
                        ],
                        color: const Color(0xffff7f41)),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context, 'image/Flamingo_1.png');
                      },
                    ),
                  ),
                  Container(
                    height: 180,
                    width: 180,
                    margin: const EdgeInsets.only(
                        top: 0, bottom: 20, left: 3, right: 3),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('image/Giraffe_1.png'),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 6,
                              spreadRadius: 0)
                        ],
                        color: const Color(0xffff7f41)),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context, 'image/Giraffe_1.png');
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 180,
                    width: 180,
                    margin: const EdgeInsets.only(
                        top: 0, bottom: 20, left: 3, right: 3),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('image/Hippo_1.png'),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 6,
                              spreadRadius: 0)
                        ],
                        color: const Color(0xffff7f41)),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context, 'image/Hippo_1.png');
                      },
                    ),
                  ),
                  Container(
                    height: 180,
                    width: 180,
                    margin: const EdgeInsets.only(
                        top: 0, bottom: 20, left: 3, right: 3),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('image/Koala_1.png'),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 6,
                              spreadRadius: 0)
                        ],
                        color: const Color(0xffff7f41)),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context, 'image/Koala_1.png');
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

//이미지 선택 관련 함수
Widget chooseImage(BuildContext context, String imageName) {
  return Container(
    height: 150,
    width: 150,
    margin: const EdgeInsets.only(top: 0, bottom: 20, left: 3, right: 3),
    decoration: BoxDecoration(
        // image: DecorationImage(
        //     image: AssetImage('image/Flamingo_1'), fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
              color: const Color(0x29000000),
              offset: Offset(0, 3),
              blurRadius: 6,
              spreadRadius: 0)
        ],
        color: const Color(0xffff7f41)),
    child: InkWell(
      child: Image.asset(imageName),
      onTap: () {},
    ),
  );
}
