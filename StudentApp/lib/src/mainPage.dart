import 'package:flutter/material.dart';
import 'sub_widget/appbar.dart';
import 'mypage.dart';
import 'tutorial.dart';
import 'sub_widget/wish_down_widget.dart';
import 'sub_widget/home_widget.dart';
import 'data.dart';

//상태 변동이 수행되어야 하는 스테이트 풀 위젯 선언
class mainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => mainPageStateful();
}

//변환되는 페이지에 대한 선언으로 위의 홈페이지 클래스의 상태를 전달한다.
class mainPageStateful extends State<mainPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    print('on Tab : ${_tabController.index}');
    setState(() {
      switch (_tabController.index) {
        case 0:
          {
            Content.refreshHistory();
            break;
          }
        case 1:
          {
            Content.refreshWishList();
            break;
          }
        case 2:
          {
            Content.refreshDownloadList();
            break;
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //각각의 위젯을 위치를 디바이스에 맞게 조정하기 위해 스마트폰의 길이를 저장
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    //마테리얼 앱 타입 반환
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //시각적 밀도 지정
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //홈, 찜목록, 퀴즈, 정보기능을 사용하기 위한 탭바 컨트롤러 선언
      home: Scaffold(
        // 상단에 탭 생성
        //appBar: //PreferredSize(
        //preferredSize: Size.fromHeight(60), child: appBar(context)),
        bottomNavigationBar: customBar(context, _tabController),
        //홈, 찜목록, 퀴즈, 사용자 정보 탭에 대한 컨텐츠 설정
        body: TabBarView(controller: _tabController, children: [
          //홈 탭에 대한 컨텐츠로 컨테이너 타입으로 위젯 시작
          // home(),
          MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Container(
                //배경색 맞춰주기 위해 색 지정
                color: const Color(0xfffbfbfb),
                // 전체적인 배치는 가운데 배치로
                child: SingleChildScrollView(
                  //내부 구성을 위해 다시 컨테이너로 묶는다.
                  // column형태로 컨텐츠 배치할것이기 떄문에 자식 위젯 지정
                  child: Column(
                    // 내부 구성 위젯
                    children: <Widget>[
                      //앱의 간단한 소개를 위한 부분을 컨테이너로 지정 후 내부에 카드선언할것임

                      Container(
                        width: _width * 0.9,
                        height: _height * 0.25,
                        padding: const EdgeInsets.all(00),
                        margin: const EdgeInsets.only(
                            top: 36, left: 27, right: 27, bottom: 27),
                        //컨테이너 형태 지정
                        decoration: BoxDecoration(
                          //기울기 지정
                          borderRadius: BorderRadius.circular(36),
                        ),
                        //컨테이너 내부 요소로 카드 선언
                        child: InkWell(
                          child: Card(
                            //그림자 밝기 지정
                            elevation: 4,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            //카드를 형태 지정
                            shape: RoundedRectangleBorder(
                                //모서리를 둥글게 만들 것이다
                                borderRadius: BorderRadius.circular(36)),
                            //1차적으로 내부 구성을 열 타입으로 생성, 소개 멘트와 이미지가 들어갈것이다
                            child: Center(
                                child: Image.asset(
                              'image/image_tutorial.png',
                              width: 350,
                              fit: BoxFit.cover,
                            )),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => tutorial()));
                          },
                        ),
                      ),

                      //중간에 위치한 choose category를 작성하기 위해 사용
                      setSub(context, 'Choose Category'),

                      //카테고리 컨테이너로 여기에Listview를 만들어 과목을 돌릴거임
                      Container(
                        //컨테이너의 크기 지정
                        height: _height / 8.2,
                        padding: const EdgeInsets.all(7),
                        margin: const EdgeInsets.only(bottom: 7),
                        // 리스트뷰 위젯 생성
                        child: ListView(
                          //가로로 스크롤 할 수 있게 지정
                          scrollDirection: Axis.horizontal,
                          //내부에 미리선언해둔 위젯 반환 함수 호출
                          children: <Widget>[
                            setListItem(context, 'Math', Icons.calculate),
                            setListItem(context, 'English', Icons.spellcheck),
                            setListItem(context, 'Science', Icons.science),
                            setListItem(context, 'Health', Icons.healing),
                            setListItem(context, 'Sports', Icons.sports),
                          ],
                        ),
                      ),
                      //과거 기록에 대한 제목을 작성하는 컨테이너를 함수로 호출
                      setSub(context, "Previous Learned Contents"),
                      //컨테이너 호출
                      Container(
                        //내부에 카드를 정렬시켜놓고 보이도록 호출
                        child: Column(
                          children: [
                            for (Content content in Content.getHistory())
                              historyCard(context, content)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          //위시리스트와 다운로드 리스트가 들어가기 위한 페이지

          MaterialApp(
            //디버그 표시는 제거
            debugShowCheckedModeBanner: false,
            //스캐폴드 위젯을 통해 기본 골자를 구성
            home: Scaffold(
              //전체적인 틀을 잡기 위한 컨테이너를 선언
              body: Container(
                //색은 앱 바에 맞춰서 흰색으로
                color: Colors.white,
                //너비는 지원 기기에 맞게 설정
                width: _width,
                //컬럼 형태로 위젯을 배치하도록 했다
                child: Column(
                  children: [
                    //위시리스트를 작성하기 위한 컬럼 할당
                    Container(
                      //위시리스트의 요소들이 들어가기 위한 공간 할당
                      height: 690,
                      //컨테이너 내부에 다시 컬럼 형태로 위젯 지정
                      child: ListView(
                        //전체적인 배치는 왼쪽에 붙도록 지정

                        //
                        children: [
                          //텍스트가 들어갈 컨테이너
                          Container(
                            width: _width,
                            margin: const EdgeInsets.symmetric(
                                vertical: 32, horizontal: 29),
                            child: Text("Wish list",
                                style: const TextStyle(
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Arial",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20.0),
                                textAlign: TextAlign.left),
                          ),
                          //텍스트 밑에 있는 바가 들어갈 컨테이너
                          Container(
                              width: 320,
                              height: 0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 29),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xffededed),
                                      width: 3))),

                          for (Content content in Content.getWish())
                            wish_list(context, content),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //wish_down(),
          MaterialApp(
            //디버그 표시는 제거
            debugShowCheckedModeBanner: false,
            //스캐폴드 위젯을 통해 기본 골자를 구성
            home: Scaffold(
              //전체적인 틀을 잡기 위한 컨테이너를 선언
              body: Container(
                //색은 앱 바에 맞춰서 흰색으로
                color: Colors.white,
                //너비는 지원 기기에 맞게 설정
                width: _width,
                //컬럼 형태로 위젯을 배치하도록 했다
                child: Column(
                  children: [
                    //위시리스트를 작성하기 위한 컬럼 할당
                    Container(
                      //위시리스트의 요소들이 들어가기 위한 공간 할당
                      height: 690,
                      //컨테이너 내부에 다시 컬럼 형태로 위젯 지정
                      child: ListView(
                        //전체적인 배치는 왼쪽에 붙도록 지정

                        //
                        children: [
                          //텍스트가 들어갈 컨테이너
                          Container(
                            width: _width,
                            margin: const EdgeInsets.symmetric(
                                vertical: 32, horizontal: 29),
                            child: Text("Download list",
                                style: const TextStyle(
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Arial",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20.0),
                                textAlign: TextAlign.left),
                          ),
                          //텍스트 밑에 있는 바가 들어갈 컨테이너
                          Container(
                              width: 320,
                              height: 0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 29),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xffededed),
                                      width: 3))),

                          for (Content content in Content.getDownload())
                            download_list(context, content),

                          // 리스트뷰가 들어갈 컨테이너
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //마지막 사용자 정보를 가져오는 컨테이너
          myPage()
        ]),
      ),
    );
  }
}
