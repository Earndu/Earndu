import 'package:shared_preferences/shared_preferences.dart';

class Manage {
  static String total = null;
  static String user = null;
  static String pwd = null;
  static String download = null;
  static int tutorialCnt = 0;
  static SharedPreferences prefs;

  static int cntVal() {
    return tutorialCnt;
  }

  static void getCnt() async {
    prefs = await SharedPreferences.getInstance();
    tutorialCnt = prefs.getInt('cnt') ?? 0;
  }

  static void incrementCnt() async {
    prefs = await SharedPreferences.getInstance();
    tutorialCnt = (prefs.getInt('cnt') ?? 0) + 1;
    prefs.setInt('cnt', tutorialCnt);
  }

  static void setPwd(String val) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('pwd', val);
  }

  static void getPwd() async {
    prefs = await SharedPreferences.getInstance();
    pwd = (prefs.getString('pwd') ?? null);
    // print(pwd);
    print('getPwd');
  }

  static void setTotal(String val) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('data1', val);
  }

  static void getTotal() async {
    prefs = await SharedPreferences.getInstance();
    total = (prefs.getString('data1') ?? null);
    // print(total);
    print('getTotal');
  }

  static void setUser(String val) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('data2', val);
  }

  static void getUser() async {
    prefs = await SharedPreferences.getInstance();
    user = (prefs.getString('data2') ?? null);
    // print(user);
    print('getUser');
  }

  static void setDownload(String val) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('data3', val);
  }

  static void getDownload() async {
    prefs = await SharedPreferences.getInstance();
    download = (prefs.getString('data3') ?? null);
    // print(download);
    print('getDownload');
  }

  static String pwdVal() {
    return pwd;
  }

  static String totalVal() {
    return total;
  }

  static String userVal() {
    return user;
  }

  static String downloadVal() {
    return download;
  }
}
