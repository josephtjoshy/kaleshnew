import 'dart:html';
import 'dart:io';
import 'dart:async';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'clockList.dart';
import 'data.dart';

bool toogleValue1 = true;
bool toogleValue2 = true;
int displayTimeon = 1, displayTimeof = 1;
Timer timer, wifiTimer;
void main() {
  runApp(Loading());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading(),
    );
  }
}

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingPage(),
    );
  }
}

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    // TODO: implement initState
    wifi();
    wifiTimer = Timer.periodic(Duration(seconds: 1), (timerwi) {
      wifi();
    });
    databaseHelper = DatabaseHelper();
    databaseHelper.getTimeDataMapList().then((value) {
      for (var map in value) {
        timeData.add(TimeData(
          id: map["id"],
          hour: map["hour"].toString(),
          min: map["min"].toString(),
          durationmin: map["durationmin"].toString(),
          durationsec: map["durationsec"].toString(),
          day1: map["day1"],
          day2: map["day2"],
          day3: map["day3"],
          day4: map["day4"],
          day5: map["day5"],
          day6: map["day6"],
          day7: map["day7"],
        ));
      }
    }).whenComplete(() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WorkingPage()));
    });

    ServerSocket.bind("0.0.0.0", 4010)
      ..then((socket) {
        serverSocket = socket;
        runZoned(() {}, onError: (e) {
          online = false;
          print('Server error 1: $e');
        });
        serverSocket.listen((sock) {}).onData((clientSocket) {
          socketClient = clientSocket;
          print(socketClient.remoteAddress);
          online = true;
        });
      })
      ..catchError((onError) {
        print(['Server error 2: ', onError.toString()]);
        online = false;
      })
      ..whenComplete(() {
        print(['Complete']);
      });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 1.25,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Center(
                  child: Text(
                    "Loading",
                    style: TextStyle(fontSize: 80),
                  ),
                ),
                LinearProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WorkingPage extends StatefulWidget {
  @override
  _WorkingPageState createState() => _WorkingPageState();
}

class _WorkingPageState extends State<WorkingPage> {
  @override
  void initState() {
    // TODO: implement initState

    timer = Timer.periodic(Duration(seconds: 1), (timer1) {
      // print(online);
      setState(() {
        if (online == true) {
          online = true;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    print("timer canceled");
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Automatic Motor"),
        actions: <Widget>[
          Center(
              child: Text(
            online == false ? "Not Connected" : "Connected",
            style: TextStyle(fontSize: 20.0),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              online == false ? Icons.remove_circle_outline : Icons.wifi,
              color: online == false ? Colors.red : Colors.green,
            ),
          )
        ],
      ),
      body: Column(children: <Widget>[
        Expanded(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 2.0),
          child: Container(
            //color: Colors.lightBlue,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              border: Border.all(),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,20.0),
                  child: Text(
                    "ON Timer",
                    style: TextStyle(fontSize: 25.0),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.pink,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.pink,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      //color: Colors.pink,
                    ),
                    Container(
                      width: 10,
                      child: Text(":"),
                      color: Colors.pink,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      //color: Colors.pink,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.pink,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.pink,
                    )
                  ],
                ),
              ],
            ),
          ),
        )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 2.0),
            child: Container(
              //color: Colors.black,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "OFF Timer",
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
      floatingActionButton: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ClockListData()));
                  },
                  heroTag: "Hour1",
                  label: Text(
                    "Hour Wise",
                    style: TextStyle(fontSize: 20),
                  )),
              FloatingActionButton.extended(
                heroTag: "set1",
                label: Text(
                  "Set",
                  style: TextStyle(fontSize: 22.0),
                ),
                onPressed: () {
                  if (online == true) {
                    List tranRepData = [];
                    tranRepData.add("Rept");
                    if (toogleValue1 == true) {
                      int displayTimeonn = displayTimeon * 60;
                      String temp = '';
                      if (displayTimeonn.toString().length == 1) {
                        temp += '000';
                        temp += displayTimeonn.toString();
                      }
                      if (displayTimeonn.toString().length == 2) {
                        temp += '00';
                        temp += displayTimeonn.toString();
                      }
                      if (displayTimeonn.toString().length == 3) {
                        temp += '0';
                        temp += displayTimeonn.toString();
                      }
                      if (displayTimeonn.toString().length == 4) {
                        temp = displayTimeonn.toString();
                      }
                      tranRepData.add(temp);
                    }
                    if (toogleValue1 == false) {
                      String temp = '';
                      if (displayTimeon.toString().length == 1) {
                        temp += '000';
                        temp += displayTimeon.toString();
                      }
                      if (displayTimeon.toString().length == 2) {
                        temp += '00';
                        temp += displayTimeon.toString();
                      }
                      if (displayTimeon.toString().length == 3) {
                        temp += '0';
                        temp += displayTimeon.toString();
                      }
                      if (displayTimeon.toString().length == 4) {
                        temp += displayTimeon.toString();
                      }
                      tranRepData.add(temp);
                    }
                    if (toogleValue2 == true) {
                      int displayTimeoff = displayTimeof * 60;
                      String temp = '';
                      if (displayTimeoff.toString().length == 1) {
                        temp += '000';
                        temp += displayTimeoff.toString();
                      }
                      if (displayTimeoff.toString().length == 2) {
                        temp += '00';
                        temp += displayTimeoff.toString();
                      }
                      if (displayTimeoff.toString().length == 3) {
                        temp += '0';
                        temp += displayTimeoff.toString();
                      }
                      if (displayTimeoff.toString().length == 4) {
                        temp += displayTimeoff.toString();
                      }
                      tranRepData.add(temp);
                    }
                    if (toogleValue2 == false) {
                      String temp = '';
                      if (displayTimeof.toString().length == 1) {
                        temp += '000';
                        temp += displayTimeof.toString();
                      }
                      if (displayTimeof.toString().length == 2) {
                        temp += '00';
                        temp += displayTimeof.toString();
                      }
                      if (displayTimeof.toString().length == 3) {
                        temp += '0';
                        temp += displayTimeof.toString();
                      }
                      if (displayTimeof.toString().length == 4) {
                        temp += displayTimeof.toString();
                      }
                      tranRepData.add(temp);
                    }
                    tranRepData.add("\r");
                    socketClient.write(tranRepData);

                    Fluttertoast.showToast(
                        msg: "Data Transmitted Succesfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    Fluttertoast.showToast(
                        msg: "No device detected",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> wifi() async {
  WiFiForIoTPlugin.isEnabled().then(
    (val) {
      if (val != null) {
        isEnabled = val;
        print('Wifi Status:$isEnabled');
        if (isEnabled == false) {
          WiFiForIoTPlugin.setEnabled(true);
          print('Wifi turned on');
        }
      }
    },
  );
  WiFiForIoTPlugin.isConnected().then(
    (val) {
      if (val != null) {
        isConnected = val;
        print('Connected:$isConnected');
      }
      if (isConnected == false) {
        online = false;
      }
    },
  );
}
