import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class appTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: appTutorialStateful());
    theme:
    ThemeData(primarySwatch: Colors.orange);
  }
}

class appTutorialStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _appTutorialStateful();
}

class _appTutorialStateful extends State<appTutorialStateful> {
  final List<String> tutorialImgList = [
    "image/appTutorial_1.png",
    "image/appTutorial_2.png",
    "image/appTutorial_3.png",
  ];
  final List<String> tutorialTextList = [
    "Skip",
    "Skip",
    "Start",
  ];

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        child: Swiper(
          pagination: SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: DotSwiperPaginationBuilder(
                color: Colors.grey, activeColor: Color(0xffff7f41)),
          ),
          itemCount: tutorialImgList.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(alignment: Alignment.center, children: <Widget>[
              Image.asset(
                tutorialImgList[index],
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 30,
                right: 10,
                child: InkWell(
                  child: Container(
                    padding: const EdgeInsets.only(top: 8),
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 6,
                              spreadRadius: 0)
                        ],
                        color: const Color(0xffff7f41)),
                    child: Text("${tutorialTextList[index]}",
                        style: const TextStyle(
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            fontFamily: "Arial",
                            fontStyle: FontStyle.normal,
                            fontSize: 20.0),
                        textAlign: TextAlign.center),
                  ),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pop(context);
                  },
                ),
              ),
            ]);
          },
        ),
      ),
    );
  }
}
