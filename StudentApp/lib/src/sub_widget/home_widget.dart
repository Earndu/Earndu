import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_app/src/contentList.dart';
import '../contentList.dart';
import '../contents.dart';
import '../data.dart';

//과목이름 갱신용
@override
Widget setSub(BuildContext context, String sub) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    alignment: Alignment(-0.72, 0.0),
    child: Text(
      '$sub',
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            blurRadius: 10.0,
            color: const Color(0x29000000),
            offset: Offset(5.0, 5.0),
          ),
        ],
      ),
    ),
  );
}

@override
//리스트 뷰 제작용
Widget setListItem(BuildContext context, String sub, IconData iconVal) {
  return Container(
    padding: const EdgeInsets.only(top: 7),
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    width: 74,
    height: 74,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(13)),
        boxShadow: [
          BoxShadow(
              color: const Color(0x29000000),
              offset: Offset(0, 3),
              blurRadius: 6,
              spreadRadius: 0)
        ],
        color: const Color(0xffffc12f)),
    child: InkWell(
      child: Column(
        children: <Widget>[
          Icon(
            iconVal,
            size: 40,
          ),
          AutoSizeText(
            sub,
            style: TextStyle(
              fontSize: 15,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      onTap: () {
        // print(Content.originalContent);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => contentListStateful(subName: sub)));
      },
    ),
  );
}

//히스토리카드 제작용
@override
Widget historyCard(BuildContext context, Content content) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 0),
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
    ),
    width: 320,
    height: 83,
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => contentsPageStateful(content: content)));
      },
      child: Container(
        width: 320,
        height: 83,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          boxShadow: [
            BoxShadow(
                color: const Color(0x29000000),
                offset: Offset(0, 3),
                blurRadius: 6,
                spreadRadius: 0)
          ],
          color: const Color(0xffffffff),
        ),
        child: Row(
          children: [
            Container(
              width: 59,
              height: 59,
              padding: const EdgeInsets.all(3),
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('image/Elephant_1.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: const Color(0xffffc12f),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(3),
              margin: const EdgeInsets.all(3),
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
