//import 'dart:js';
import 'package:flutter/material.dart';

import 'src/login.dart';

//플루터 시작 부분
void main() {
  runApp(MaterialApp(
    //앱을 시작하는 함수, 여기서부터 시작된다.

    debugShowCheckedModeBanner: false,
    title: 'Start',
    home: Login_Page(),
  ));
}
