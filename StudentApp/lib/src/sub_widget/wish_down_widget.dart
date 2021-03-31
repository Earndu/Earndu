import 'package:flutter/material.dart';
import 'package:flutter_app/src/data.dart';
import 'package:flutter_app/src/manageState.dart';
import '../contents.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:auto_size_text/auto_size_text.dart';

//리스트  요소 함수
Widget wish_list(BuildContext context, Content content) {
  return InkWell(
    onTap: () {
      showCupertinoModalBottomSheet(
          backgroundColor: Color(0xfffbfbfb),
          expand: true,
          context: context,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              controller: ModalScrollController.of(context),
              child: Container(
                padding: const EdgeInsets.all(28),
                child: Column(
                  children: [
                    Container(
                        child: Row(
                      children: <Widget>[
                        Container(
                            width: 59,
                            height: 59,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13)),
                                color: const Color(0xffffc12f))),
                        Container(
                          height: 50,
                          width: 200,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: AutoSizeText(content.title,
                                      style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          color: const Color(0xff3d4047),
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Arial",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 20.0),
                                      maxLines: 1,
                                      minFontSize: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left)),
                              Container(
                                  margin: const EdgeInsets.only(top: 9),
                                  alignment: Alignment.bottomLeft,
                                  child: Text(content.category,
                                      style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          color: const Color(0xff5c5d60),
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Arial",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 15.0),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left)),
                            ],
                          ),
                        )
                      ],
                    )),
                    Container()
                  ],
                ),
              ),
            );
          });
    },
    child: Container(
      width: 300,
      height: 83,
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          boxShadow: [
            BoxShadow(
                color: const Color(0x29000000),
                offset: Offset(0, 3),
                blurRadius: 6,
                spreadRadius: 0)
          ],
          color: const Color(0xffffffff)),
      child: Row(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(left: 17),
              width: 59,
              height: 59,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  color: const Color(0xffffc12f))),
          Container(
            margin: const EdgeInsets.only(left: 17),
            width: 150,
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 11, bottom: 4),
                  child: Text(content.title,
                      style: const TextStyle(
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w700,
                          fontFamily: "Arial",
                          fontStyle: FontStyle.normal,
                          fontSize: 15.0),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left),
                ),
                Container(
                  child: Text(content.teacher.fullname,
                      style: const TextStyle(
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Arial",
                          fontStyle: FontStyle.normal,
                          fontSize: 10.0),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left),
                )
              ],
            ),
          ),
          InkWell(
            child: Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(left: 25, top: 30),
              child: Icon(
                Icons.favorite,
                size: 30,
                color: Color(0xffff7f41),
              ),
            ),
            onTap: () => FlutterDialog(context, content.id, 1),
          )
        ],
      ),
    ),
  );
}

//다운로드 리스트  요소 함수
Widget download_list(BuildContext context, Content content) {
  bool favoritePressed = false;
  int remain = 0;
  return Container(
    width: 280,
    height: 83,
    margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        boxShadow: [
          BoxShadow(
              color: const Color(0x29000000),
              offset: Offset(0, 3),
              blurRadius: 6,
              spreadRadius: 0)
        ],
        color: const Color(0xffffffff)),
    child: InkWell(
      child: Row(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(left: 17),
              width: 59,
              height: 59,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  color: const Color(0xffffc12f))),
          Container(
            margin: const EdgeInsets.only(left: 17),
            width: 150,
            height: 83,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 11, bottom: 4),
                  child: Text(content.title,
                      style: const TextStyle(
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w700,
                          fontFamily: "Arial",
                          fontStyle: FontStyle.normal,
                          fontSize: 15.0),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left),
                ),
                Container(
                  child: Text(content.teacher.fullname,
                      style: const TextStyle(
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Arial",
                          fontStyle: FontStyle.normal,
                          fontSize: 10.0),
                      textAlign: TextAlign.left),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: InkWell(
                          child: Icon(
                            Icons.delete,
                            color: Color(0xffff7f41),
                          ),
                          onTap: () {
                            FlutterDialog(context, content.id, 2);
                          },
                        ),
                      ),
                      Container(
                        child: Text("$remain" + ' week later',
                            style: const TextStyle(
                                color: const Color(0xff5c5d60),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Arial",
                                fontStyle: FontStyle.normal,
                                fontSize: 10.0)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          //컨텐츠 이용 페이지로 이동
          Container(
            width: 30,
            height: 60,
            margin: const EdgeInsets.only(
              left: 25,
            ),
            child: IconButton(
              iconSize: 25.0,
              icon: Icon(
                Icons.keyboard_arrow_right,
                color: Color(
                  0xffff7f41,
                ),
                size: 50,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            contentsPageStateful(content: content)));
              },
            ),
          )
        ],
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => contentsPageStateful(content: content)));
      },
    ),
  );
}

void FlutterDialog(BuildContext context, int contentId, int type) {
  // final earndu = Provider.of<earnduData>(context);
  showDialog(
      context: context,
      //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          //Dialog Main Title
          title: Column(
            children: <Widget>[
              new Text("Delete"),
            ],
          ),
          //
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Delete this contents?",
              ),
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                switch (type) {
                  // 위시리스트
                  case 1:
                    {
                      Content.removeFromWishList(contentId);
                      //Provider를 통해 값 갱신
                      Manage.setUser(Content.metaToString());
                      //Manage.getUser();
                      break;
                    }
                  // 다운로드 리스트
                  case 2:
                    {
                      Content.removeFromDownloadList(contentId);
                      //Provider를 통해 값 갱신
                      Manage.setUser(Content.metaToString());
                      //Manage.getUser();
                      break;
                    }
                }
                Navigator.pop(context);
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
