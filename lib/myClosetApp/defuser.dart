import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var _count2 = 1;
var scant = 3;
var hour = 07;
var minute = 30;

var url1 = Uri.parse('http://192.168.200.143:5000/schedule_post');
//시간 예약 전송 주소
var url2 = Uri.parse('http://192.168.200.143:5000/defuse_post');
//디퓨저 설정 전송 주소

Future<Info> fetchInfo() async {
  var url3 = '/recive_data';
  // 방향제 정보 받을 데이터
  final response = await http.get(Uri.parse(url3));

  if (response.statusCode == 200) {
    //만약 서버가 ok응답을 반환하면, json을 파싱합니다
    print('응답했다');
    print(json.decode(response.body));
    return Info.fromJson(json.decode(response.body));
  } else {
    //만약 응답이 ok가 아니면 에러를 던집니다.
    throw Exception('정보를 불러오는데 실패했습니다.');
  }
}

class Info {
  final String time;
  final int choice;
  final String mon;
  final String tue;
  final String wed;
  final String thu;
  final String fri;
  final String sat;
  final String sun;

  Info(
      {required this.time,
      required this.choice,
      required this.mon,
      required this.tue,
      required this.wed,
      required this.thu,
      required this.fri,
      required this.sat,
      required this.sun});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      time: json["time"],
      choice: json["choice"],
      mon: json["mon"],
      tue: json["tue"],
      wed: json["wed"],
      thu: json["thu"],
      fri: json["fri"],
      sat: json["sat"],
      sun: json["sun"],
    );
  }
}

class defuserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _defuserPage();
}

class _defuserPage extends State<defuserPage> {
  Future<Info>? info;
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  String? _selectedTime;

  @override
  void initState() {
    super.initState();
    info = fetchInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'IoT 제어',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: FutureBuilder<Info>(
            //통신데이터 가져오기
            future: info,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return buildColumn2(snapshot);
              } else if (snapshot.hasError) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FloatingActionButton.large(
                                onPressed: () {
                                  scant = 0;
                                  varCount2();
                                  _callAPI_1();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '차분한',
                                    ),
                                    Text('머스크향')
                                  ],
                                ),
                              ),
                              FloatingActionButton.large(
                                onPressed: () {
                                  scant = 1;
                                  varCount2();
                                  _callAPI_2();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '부드러운',
                                    ),
                                    Text('라벤더향')
                                  ],
                                ),
                              ),
                              FloatingActionButton.large(
                                onPressed: () {
                                  scant = 2;
                                  varCount2();
                                  _callAPI_3();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '달콤한',
                                    ),
                                    Text('블랙체리향')
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            onPressed: () {
                              scant = 3;
                              varCount2();
                              _callAPI_4();
                            },
                            child: Text('전체 끄기'),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      // dehumi
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _callAPI();
                                  },
                                  child: Text('월'),
                                ),
                              ),
                              Container(
                                width: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _callAPI2();
                                  },
                                  child: Text('화'),
                                ),
                              ),
                              Container(
                                width: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _callAPI3();
                                  },
                                  child: Text('수'),
                                ),
                              ),
                              Container(
                                width: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _callAPI4();
                                  },
                                  child: Text('목'),
                                ),
                              ),
                              Container(
                                width: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _callAPI5();
                                  },
                                  child: Text('금'),
                                ),
                              ),
                              Container(
                                width: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _callAPI6();
                                  },
                                  child: Text('토'),
                                ),
                              ),
                              Container(
                                width: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _callAPI7();
                                  },
                                  child: Text('일'),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Future<TimeOfDay?> selectedTime = showTimePicker(
                                initialTime: TimeOfDay.now(),
                                context: context,
                              );
                              selectedTime.then((value) {
                                setState(() {
                                  if (value == null) {
                                    _selectedTime = null;
                                  } else {
                                    _selectedTime =
                                        '${value.hour}:${value.minute}';
                                  }
                                });
                              });
                              scant = 3;
                              varCount2();
                              _callAPI_4();
                            },
                            child: Text('예약 하기'),
                          ),
                        ],
                      ),
                    ]);
              }
              return CircularProgressIndicator();
            },
          ),
        ));
  }

  Widget buildColumn2(snapshot) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
            controller: myController1,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '예약 시간 입력',
            )),

        TextField(
            controller: myController2,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '예약 분 입력',
            )),

        Text("디퓨저 현황 ", style: TextStyle(fontSize: 25)),
        Text('시간: ' + snapshot.data!.time.toString() + '으로 설정되었습니다.',
            style: TextStyle(fontSize: 15)),
        Text('월요일: ' + snapshot.data!.mon.toString() + '상태입니다.',
            style: TextStyle(fontSize: 15)),
        Text('화요일: ' + snapshot.data!.tue.toString() + '상태입니다.',
            style: TextStyle(fontSize: 15)),
        Text('수요일: ' + snapshot.data!.wed.toString() + '상태입니다.',
            style: TextStyle(fontSize: 15)),
        Text('목요일: ' + snapshot.data!.thr.toString() + '상태입니다.',
            style: TextStyle(fontSize: 15)),
        Text('금요일: ' + snapshot.data!.fri.toString() + '상태입니다.',
            style: TextStyle(fontSize: 15)),
        Text('토요일: ' + snapshot.data!.sat.toString() + '상태입니다.',
            style: TextStyle(fontSize: 15)),
        Text('일요일: ' + snapshot.data!.sun.toString() + '상태입니다.',
            style: TextStyle(fontSize: 15)),
        Text('향기: ' + snapshot.data!.choice.toString() + '번째 향기입니다.',
            style: TextStyle(fontSize: 15)),
        SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              scant = 0;
              varCount2();
              _callAPI_1();
            },
            child: Text('1번째 향')),
        SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              scant = 1;
              varCount2();
              _callAPI_2();
            },
            child: Text('2번째 향')),
        SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              scant = 2;
              varCount2();
              _callAPI_3();
            },
            child: Text('3번째 향')),
        SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              scant = 3;
              varCount2();
              _callAPI_4();
            },
            child: Text('끄기')),
        SizedBox(height: 30),

        // dehumi
        ElevatedButton(
            onPressed: () {
              _callAPI();
            },
            child: Text('월')),
        ElevatedButton(
            onPressed: () {
              _callAPI2();
            },
            child: Text('화')),
        SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              _callAPI3();
            },
            child: Text('수')),
        SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              _callAPI4();
            },
            child: Text('목')),
        SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              _callAPI5();
            },
            child: Text('금')),
        SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              _callAPI6();
            },
            child: Text('토')),
        SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              _callAPI7();
            },
            child: Text('일')),
      ],
    );
  }

  //dehumi
  void _callAPI() async {
    await http.post(url1, body: {
      'time': '${myController1.text}' + ':' + '${myController2.text}',
      'choice': '$scant',
      'mon': 'on',
      'tue': 'off',
      'wed': 'off',
      'thu': 'off',
      'fri': 'off',
      'sat': 'off',
      'sun': 'off'
    });
  }

  void _callAPI2() async {
    await http.post(url1, body: {
      'time': '${myController1.text}' + ':' + '${myController2.text}',
      'choice': '$scant',
      'mon': 'off',
      'tue': 'on',
      'wed': 'off',
      'thu': 'off',
      'fri': 'off',
      'sat': 'off',
      'sun': 'off'
    });
  }

  void _callAPI3() async {
    await http.post(url1, body: {
      'time': '${myController1.text}' + ':' + '${myController2.text}',
      'choice': '$scant',
      'mon': 'off',
      'tue': 'off',
      'wed': 'on',
      'thu': 'off',
      'fri': 'off',
      'sat': 'off',
      'sun': 'off'
    });
  }

  void _callAPI4() async {
    await http.post(url1, body: {
      'time': '${myController1.text}' + ':' + '${myController2.text}',
      'choice': '$scant',
      'mon': 'off',
      'tue': 'off',
      'wed': 'off',
      'thu': 'on',
      'fri': 'off',
      'sat': 'off',
      'sun': 'off'
    });
  }

  void _callAPI5() async {
    await http.post(url1, body: {
      'time': '${myController1.text}' + ':' + '${myController2.text}',
      'choice': '$scant',
      'mon': 'off',
      'tue': 'off',
      'wed': 'off',
      'thu': 'off',
      'fri': 'on',
      'sat': 'off',
      'sun': 'off'
    });
  }

  void _callAPI6() async {
    await http.post(url1, body: {
      'time': '${myController1.text}' + ':' + '${myController2.text}',
      'choice': '$scant',
      'mon': 'off',
      'tue': 'off',
      'wed': 'off',
      'thu': 'off',
      'fri': 'off',
      'sat': 'on',
      'sun': 'off'
    });
  }

  void _callAPI7() async {
    await http.post(url1, body: {
      'time': '${myController1.text}' + ':' + '${myController2.text}',
      'choice': '$scant',
      'mon': 'off',
      'tue': 'off',
      'wed': 'off',
      'thu': 'off',
      'fri': 'off',
      'sat': 'off',
      'sun': 'on'
    });
  }

  void _callAPI_1() async {
    await http.post(url2, body: {'number': '$scant', 'state': '$_count2'});
  }

  void _callAPI_2() async {
    await http.post(url2, body: {'number': '$scant', 'state': '$_count2'});
  }

  void _callAPI_3() async {
    await http.post(url2, body: {'number': '$scant', 'state': '$_count2'});
  }

  void _callAPI_4() async {
    await http.post(url2, body: {'number': '$scant', 'state': '$_count2'});
  }

  void varCount2() {
    if (_count2 == 1) {
      _count2 = 2;
    } else {
      _count2 = 1;
    }
  }
}
