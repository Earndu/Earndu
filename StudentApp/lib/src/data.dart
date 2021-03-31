import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class Student {
  //유저 정보를 저장할 변수들
  static String username = null;
  static String fullname = null;
  static String email = null;
  static DateTime birthday = null;
  static int imagedata = null;

  // *** 어플 실행 시 저장된 데이터 불러와야함 ***
  static void setUsername(String _username) {
    username = _username;
  }

  static void setFullName(String _fullName) {
    fullname = _fullName;
  }

  static void setEmail(String _email) {
    email = _email;
  }

  static void setBirthday(DateTime _birthday) {
    birthday = _birthday;
  }

  static void setImageId(int _imageData) {
    imagedata = _imageData;
  }

  static Future<Map> postRequest(String username, String password) async {
    var url = 'https://svclaw.ipdisk.co.kr:11003/student/total';

    // 다운로드 리스트에 이미 존재하는 컨텐츠는 다시 다운받지 않음
    List<int> wishList = [];
    for (int idx in Content.wishList) {
      if (!Content.downloadList.contains(idx)) {
        wishList.add(idx);
      }
    }

    Map postData = {
      "username": username,
      "password": password,
      "wish_list": wishList
    };

    if (Curriculum.list.isNotEmpty) {
      List<Map> curriculum = List();
      for (Curriculum item in Curriculum.list) {
        Map curItem = {
          'content_id': item.contentId,
          'percentage': item.percentage
        };

        if (item.score != null) {
          curItem['score'] = item.score;
          curItem['end_datetime'] = item.endDate;
        }

        curriculum.add(curItem);
      }

      postData['curriculum'] = curriculum;
    }

    var body = json.encode(postData);

    var rawResponse = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    var response = json.decode(rawResponse.body);
    print('response: $response');

    return response;
  }
}

// Contents a = new Contents(1, '따님을제게줏빗이보', 20, 22.0, 100);
// List<Contents> maradona = [a];

//카테고리에 대한 클래스

class Content {
  // 데이터 원본 저장
  static Map<String, dynamic> originalContent = {};
  static List<Map> originalDownload = [];

  static List<Content> totalList = List();

  static List<int> wishList = List();

  //static List<int> wishList = [16];
  static List<int> downloadList = List();
  static List<int> historyList = List();
  static List<String> categoryList = ['Math', 'Science', 'English'];
  static String selectedType = null;

  int id = null;
  String category = null;
  String type = null;
  String title = null;
  int level = null;
  String content = null;
  List<Image> res_image = null;
  String res_sound = null;

  Teacher teacher;

  // int percentage;
  // int score;
  // var end_datetime = DateTime.parse("2021-03-01 13:32");
  // Teacher cuty;

  /*Contents(int id, String titile, int level, double percentage, int score) {
    this.id = id;
    this.title = title;
    this.level = level;
    this.percentage = percentage;
    this.score = score;
  }*/

  Content.fromJson(Map<String, dynamic> data, String type, String category) {
    this.id = data['id'];
    this.category = (category == null) ? data['category'] : category;
    this.type = (type == null) ? data['type'] : type;
    this.title = data['title'];
    this.level = data['level'];
    this.teacher = Teacher.fromJson(data['teacher']);
  }

  Content.detailFromJson(Map<String, dynamic> data) {
    id = data['id'];
    category = data['category'];
    type = data['type'].toString();
    title = data['title'];
    level = data['level'];
    teacher = Teacher.fromJson(data['teacher']);
    content = data['content'];
    res_sound = data['res_sound'];
    res_image = [
      for (String _image in data['res_image'].toString().split('<SEP>'))
        Image.memory(base64.decode(_image))
    ];
  }

  static List<Content> getType(String type) {
    List<Content> ret = List();
    for (Content content in Content.totalList) {
      if (content.type == type) {
        ret.add(content);
      }
    }
    return ret;
  }

  static List<Content> getDetailType(String type) {
    List<Content> ret = List();
    for (int i in Content.downloadList) {
      if (Content.totalList[i].type == type) {
        ret.add(Content.totalList[i]);
      }
    }
    return ret;
  }

  static int getIndexById(int contentId) {
    for (int i = 0; i < Content.totalList.length; i++) {
      if (Content.totalList[i].id == contentId) {
        return i;
      }
    }
    return null;
  }

  static Content getById(int contentId) {
    int index = getIndexById(contentId);
    if (index == null) {
      return null;
    } else {
      return totalList[index];
    }
  }

  static List<Content> getByCategory(String category) {
    List<Content> ret = List();
    for (int i = 0; i < Content.totalList.length; i++) {
      if (Content.totalList[i].type == selectedType &&
          Content.totalList[i].category == category) {
        ret.add(Content.totalList[i]);
      }
    }
    return ret;
  }

  static void removeFromDownloadList(int contentId) {
    downloadList.remove(contentId);
  }

  static void addToWishList(int contentId) {
    wishList.add(contentId);
  }

  static void removeFromWishList(int contentId) {
    wishList.remove(contentId);
  }

  static void watch(int contentId) {
    if (historyList.contains(contentId)) {
      historyList.remove(contentId);
    }
    historyList.insert(0, contentId);
  }

  static void refreshHistory() {
    historyList.add(0);
    historyList.removeLast();
  }

  static void refreshWishList() {
    wishList.add(0);
    wishList.removeLast();
  }

  static void refreshDownloadList() {
    downloadList.add(0);
    downloadList.removeLast();
  }

  static List<Content> getHistory() {
    List<Content> ret = List();
    for (int i in historyList) {
      Content content = getById(i);
      if (content.type == selectedType) {
        ret.add(content);
      }
    }
    return ret;
  }

  static List<Content> getWish() {
    List<Content> ret = List();
    for (int i in wishList) {
      Content content = getById(i);
      if (content.type == selectedType) {
        ret.add(content);
      }
    }
    return ret;
  }

  static List<Content> getDownload() {
    List<Content> ret = List();
    for (int i in downloadList) {
      Content content = getById(i);
      if (content.type == selectedType) {
        ret.add(content);
      }
    }
    return ret;
  }

  static String metaToString() {
    Map<String, dynamic> ret = Map();
    ret['wishList'] = wishList;
    ret['downloadList'] = downloadList;
    ret['historyList'] = historyList;
    ret['user'] = {
      'username': Student.username,
      'fullname': Student.fullname,
      'email': Student.email,
      'birthday': (Student.birthday == null)
          ? null
          : DateFormat('yyyy-MM-dd').format(Student.birthday),
      'imagedata': Student.imagedata,
    };
    return json.encode(ret);
  }

  static void loadMetaFromString(String str) {
    if (str == null) return;
    Map<String, dynamic> data = json.decode(str);
    wishList = List<int>.from(data['wishList']);
    downloadList = List<int>.from(data['downloadList']);
    historyList = List<int>.from(data['historyList']);
    Student.username = data['user']['username'];
    Student.fullname = data['user']['fullname'];
    Student.email = data['user']['email'];
    Student.birthday = DateFormat('yyyy-MM-dd').parse(data['user']['birthday']);
    Student.imagedata = data['user']['imagedata'];
  }

  static String contentToString() {
    String str = json.encode(originalContent);
    return str;
  }

  static void loadContentFromString(String str) {
    if (str == null) return;
    Map contents = json.decode(str);
    loadContentFromMap(contents);
  }

  static void loadContentFromMap(
      Map<String, dynamic> contents) {

    for (String type in contents.keys) {
      for (String category in contents[type].keys) {
        for (Map content in contents[type][category]) {
          Content.totalList.add(Content.fromJson(content, type, category));
        }
      }
    }
  }

  static String downloadToString() {
    String str = json.encode(originalDownload);
    return str;
  }

  static void loadDownloadFromString(String str) {
    if (str == null) return;
    List<Map> downloads = List<Map<String, dynamic>>.from(json.decode(str));
    loadDownloadFromMap(downloads);
  }

  static void loadDownloadFromMap(List<Map> downloads) {
    for (Map _content in downloads) {
      Content content = Content.detailFromJson(_content);
      // 이미 다운로드 받은 컨텐츠는 추가하지 않음
      if (!Content.downloadList.contains(content.id)) {
        Content.totalList[Content.getIndexById(content.id)] = content;
        Content.downloadList.add(content.id);
      }
    }
  }
}

class Teacher {
  int id = null;
  String fullname = null;

  Teacher.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    fullname = data['fullname'];
  }
}

class Curriculum {
  static List<Curriculum> list = List();

  int contentId = null;
  int percentage = null;
  int score = null;
  String endDate = null;

  Curriculum.fromJson(Map<String, dynamic> data) {
    this.contentId = data['content_id'];
    this.percentage = data['percentage'];
    this.score = data['score'];
    this.endDate = data['end_datetime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'content_id': contentId,
      'percentage': percentage,
      'score': score,
      'end_datetime': endDate
    };
  }
}
