import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime firstDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(  // ➊
        top: true,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,  // ➋
          children: [
            _DDay(
              onHeartPressed: onHeartPressed,  // ➎
              firstDay: firstDay,
            ),
            _CoupleImage(),
          ],
        ),
      ),
    );
  }

  void onHeartPressed(){  // ➍
    final now = DateTime.now();
    showCupertinoDialog(  // ➋
      context: context,
      builder: (BuildContext context) {
        return Align(  // ➊ 정렬을 지정하는 위젯
          alignment: Alignment.bottomCenter,  // ➋ 아래 중간으로 정렬
          child: Container(
            color: Colors.white,  // ➌ 배경색 흰색 지정
            height: 300,  // ➍ 높이 300 지정
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime date) {
                setState(() {
                  firstDay = date;
                });
              },
            ),
          ),
        );
      },
      barrierDismissible: true,  // ➎ 외부 탭할 경우 다이아로그 닫기
    );
  }
}

class _DDay extends StatelessWidget {
  final GestureTapCallback onHeartPressed;  // ➊
  final DateTime firstDay;

  _DDay({
    required this.onHeartPressed,  // ➋
    required this.firstDay,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final now = DateTime.now();

    return Column(
      children: [
        const SizedBox(height: 16.0),
        Text( // 최상단 U&I 글자
          'U&I',
          style: textTheme.headline1,
        ),
        const SizedBox(height: 16.0),
        Text( // 두번째 글자
          '우리 처음 만난 날',
          style: textTheme.bodyText1,
        ),
        Text(  // 임시로 지정한 만난 날짜
          '${firstDay.year}.${firstDay.month}.${firstDay.day}',
            style: textTheme.bodyText2,
        ),
        const SizedBox(height: 16.0),
        IconButton(  // 하트 아이콘 버튼
          iconSize: 60.0,
          onPressed: onHeartPressed,
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(  // 만난 후 DDay
          'D+${DateTime(now.year, now.month, now.day).difference(firstDay).inDays + 1}',
          style: textTheme.headline2,
        ),
      ],
    );
  }
}

class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(  // ➊
      child: Image.asset(
        'asset/img/middle_image.png',
        height: MediaQuery.of(context).size.height / 2,  // ➋
      ),
    );
  }
}

