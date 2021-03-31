import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

//라인 차트를 구성하는 옵션
LineChartData mainData(int cnt, Map<int, int> studyTime) {
  double dateval;

  if (cnt == 0) {
    dateval = 6;
  } else if (cnt == 1) {
    dateval = 29;
  } else {
    dateval = 364;
  }

  List<FlSpot> tmp = List<FlSpot>();

  for (var i in studyTime.keys) {
    FlSpot a = FlSpot(i.toDouble(), studyTime[i].toDouble());
    tmp.add(a);
  }
  return LineChartData(
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        //이부분을 버튼 누를때마다 바뀔 수 있도록 변수로 지정해주어야 한다.
        reservedSize: 22,
        getTextStyles: (dateval) => const TextStyle(
            color: Color(0xffff7f41),
            fontWeight: FontWeight.bold,
            fontSize: 13),
        getTitles: (dateval) {
          if (cnt == 0) {
            switch (dateval.toInt()) {
              case 0:
                return 'Mon';
              case 1:
                return 'Tue';
              case 2:
                return 'Wen';
              case 3:
                return 'Thu';
              case 4:
                return 'Fri';
              case 5:
                return 'Sat';
              case 6:
                return 'Sun';
            }
            return '';
          } else if (cnt == 1) {
            switch (dateval.toInt()) {
              case 7:
                return 'Week1';
              case 14:
                return 'Week2';
              case 21:
                return 'Week3';
              case 28:
                return 'Week4';
            }
            return '';
          } else {
            switch (dateval.toInt()) {
              case 30:
                return 'JAN';
              case 90:
                return 'MAR';
              case 150:
                return 'MAY';
              case 210:
                return 'JUl';
              case 270:
                return 'SEP';
              case 330:
                return 'NOV';
            }
            return '';
          }
        },
        margin: 8,
      ),
      leftTitles: SideTitles(
        showTitles: false,
      ),
    ),
    borderData: FlBorderData(
      show: false,
    ),
    minX: 0,
    maxX: dateval,
    minY: 0,
    maxY: 15,
    lineBarsData: [
      LineChartBarData(
        spots: tmp,
        isCurved: true,
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
      ),
    ],
  );
}

//파이차트 데이터
List<PieChartSectionData> showingSections(int touchedIndex, List<int> subVal) {
  T sum<T extends num>(T lhs, T rhs) => lhs + rhs;
  int resultVal = subVal.reduce(sum);
  return List.generate(5, (i) {
    final isTouched = i == touchedIndex;
    final double fontSize = isTouched ? 20 : 16;
    final double radius = isTouched ? 60 : 50;
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: const Color(0xffffaf57),
          value: (subVal[0] / resultVal) * 100,
          title: 'Math',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 1:
        return PieChartSectionData(
          color: const Color(0xffff7f41),
          //변수로 지정해 주어야 하는 부분
          value: (subVal[1] / resultVal) * 100,
          title: 'English',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 2:
        return PieChartSectionData(
          color: const Color(0xffff5f57),
          value: (subVal[2] / resultVal) * 100,
          title: 'History',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 3:
        return PieChartSectionData(
          color: const Color(0xffffdfc1),
          value: (subVal[3] / resultVal) * 100,
          title: 'Science',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 4:
        return PieChartSectionData(
          color: const Color(0xffffdf57),
          value: (subVal[4] / resultVal) * 100,
          title: 'Sports',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      default:
        return null;
    }
  });
}
