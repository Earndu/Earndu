//컨텐츠 내용을 표시하는 페이지 컨텐츠 타입에 따라 표시되는 내용이 다르다.

import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'data.dart';

class contentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.orange),
      home: contentsPageStateful(),
    );
  }
}

class contentsPageStateful extends StatefulWidget {
  final Content content;
  contentsPageStateful({Key key, this.content}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _contentsPageStateful();
}

//일단 제목은 이전 페이지의 터치로부터 가져오는 것이며, 내용 자체는 provider에서 가져오는 것으로 진행
class _contentsPageStateful extends State<contentsPageStateful> {
  bool _play = false;
  AssetsAudioPlayer _player = null;

  @override
  void dispose() {
    if (_player != null && _player.isPlaying.value) {
      _player.stop();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.content.type == '1' && _player == null) {
      print('start makefile');
      _makeFile();
      print('end makefile');
    }
    Content.watch(widget.content.id);

    String contentsVal = widget.content.type;
    double _width = MediaQuery.of(context).size.width;

    List<Image> imgList = [
      Image.asset("image/math_1.png", fit: BoxFit.cover),
      Image.asset("image/math_1.png", fit: BoxFit.cover),
      Image.asset("image/math_1.png", fit: BoxFit.cover),
      Image.asset("image/math_1.png", fit: BoxFit.cover),
      Image.asset("image/math_1.png", fit: BoxFit.cover),
      // data,
      // data,
      // data,
      // data,
    ];

    String ContentName = "sound/RunningMate.mp3";
    String readcontentsName = 'read/summary.md';

    return Scaffold(
      body: Container(
        width: _width,
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 47, left: 28),
              margin: const EdgeInsets.only(bottom: 12),
              alignment: Alignment.topLeft,
              child: // Mathsub
                  Text(widget.content.title,
                      style: const TextStyle(
                          color: const Color(0xff3d4047),
                          fontWeight: FontWeight.w700,
                          fontFamily: "Arial",
                          fontStyle: FontStyle.normal,
                          fontSize: 20.0),
                      textAlign: TextAlign.left),
            ),
            Container(
                width: 320,
                height: 0,
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 29),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xffededed), width: 3))),
            if (contentsVal == '1')
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: 300,
                  height: 600,
                  child: soundContents(context))
            else if (contentsVal == '2')
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: 300,
                  height: 670,
                  child: imageContents(context))
            else
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: 300,
                  height: 670,
                  child: readContents(context))
          ],
        )),
      ),
    );
  }

  Widget soundContents(BuildContext context) {
    if (_player == null) {
      return null;
    }

    return FloatingActionButton(
        backgroundColor: Color(0xffff7f41),
        child: Icon(
          _play ? Icons.pause : Icons.play_arrow,
          size: 230,
        ),
        onPressed: () {
          setState(() {
            if (_play) {
              _player.pause();
            } else {
              _player.play();
            }
            _play = !_play;
          });
        });
  }

//마크다운  파일을 가져오기 위한  함수 Future는 값이 할당되고 나서 타입이 결정
  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }

  Widget readContents(BuildContext context) {
    return Center(
      child: Markdown(
        data: widget.content.content,
        selectable: true,
        styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
            .copyWith(textScaleFactor: 0.8),
      ),
    );
  }

  Widget imageContents(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.content.res_image.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: (widget.content.res_image[index]),
              ));
        },
      ),
    );
  }

  Future<Null> _makeFile() {
    getTemporaryDirectory().then((tempDir) {
      File tempFile = File('${tempDir.path}/temp.mp3');
      tempFile
          .writeAsBytes(base64.decode(widget.content.res_sound), flush: true)
          .then((value) {
        setState(() {
          _player = AssetsAudioPlayer();
          _player.open(Audio.file(tempFile.path));
        });
      });
    });
  }
}
