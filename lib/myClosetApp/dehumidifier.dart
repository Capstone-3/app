import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var _count1de = 1;
var waterlevel2 = 0;
var url1de = Uri.parse('http://192.168.200.143:5000/dehumi_post'); // 수분 정보 보내는 주소

Future<Infode> fetchInfode() async {
  var url2 = '/recive_data'; // 수분 정보 받을 데이터

  final response = await http.get(Uri.parse(url2));

  if (response.statusCode == 200) {
    //만약 서버가 ok응답을 반환하면, json을 파싱합니다.
    print('응답했다');
    print(json.decode(response.body));
    return Infode.fromJson(json.decode(response.body));
  } else {
    //만약 응답이 ok가 아니면 에러를 던집니다.
    throw Exception('정보를 불러오는데 실패했습니다.');
  }
}

class Infode {
  final int temperature;
  final int humidity;
  final int waterlevel;
  final int state;

  Infode(
      {required this.temperature,
      required this.humidity,
      required this.waterlevel,
      required this.state});

  factory Infode.fromJson(Map<String, dynamic> json) {
    return Infode(
      temperature: json["temperature"],
      humidity: json["humidity"],
      waterlevel: json["waterlevel"],
      state: json["state"],
    );
  }
}

class dehumidifierPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _dehumidifierPage();
}

class _dehumidifierPage extends State<dehumidifierPage> {
  Future<Infode>? infode;

  @override
  void initState() {
    super.initState();
    infode = fetchInfode();
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
            '제습기 관리',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: FutureBuilder<Infode>(
            //통신데이터 가져오기
            future: infode,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return buildColumn(snapshot);
              } else if (snapshot.hasError) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("연결 실패 에러!!", style: TextStyle(fontSize: 25)),
                      SizedBox(height: 50),
                      ElevatedButton(
                          onPressed: () {
                            varCount1de();
                            _callAPIde();
                          },
                          child: Text('ON')),
                      SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () {
                            varCount1de();
                            _callAPI2de();
                          },
                          child: Text('OFF')),
                      SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () {
                            varCount1de();
                            _callAPI3de();
                          },
                          child: Text('AUTO')),
                      SizedBox(height: 10),
                    ]);
              }

              return CircularProgressIndicator();
            },
          ),
        ));
  }

  Widget buildColumn(snapshot) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("제습기 상황", style: TextStyle(fontSize: 25)),
        Text('온도:' + snapshot.data!.temperature.toString() + '도',
            style: TextStyle(fontSize: 15)),
        Text('습도:' + snapshot.data!.humidity.toString(),
            style: TextStyle(fontSize: 15)),
        Text(
            '수위:' +
                snapshot.data!.waterlevel.toString() +
                '     1일 경우 물을 버려주세요',
            style: TextStyle(fontSize: 15)),
        Text('상태:' + snapshot.data!.state.toString(),
            style: TextStyle(fontSize: 15)),
        ElevatedButton(
            onPressed: () {
              varCount1de();
              _callAPIde();
            },
            child: Text('ON')),
        SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              varCount1de();
              _callAPI2de();
            },
            child: Text('OFF')),
        SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              varCount1de();
              _callAPI3de();
            },
            child: Text('AUTO')),
        SizedBox(height: 10),
      ],
    );
  }

  void varCount1de() {
    if (_count1de == 1) {
      _count1de = 2;
    } else {
      _count1de = 1;
    }
  }

  void _callAPIde() async {
    await http.post(url1de, body: {'inst': 'ON', 'state': '$_count1de'});
  }

  void _callAPI2de() async {
    await http.post(url1de, body: {'inst': 'OFF', 'state': '$_count1de'});
  }

  void _callAPI3de() async {
    await http.post(url1de, body: {'inst': 'AUTO', 'state': '$_count1de'});
  }
}
