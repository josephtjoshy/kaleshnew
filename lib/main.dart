import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'clockList.dart';
import 'data.dart';

bool toogleValue1 = true;
bool toogleValue2 = true;
int displayTime = 1;
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
    databaseHelper = DatabaseHelper();
    databaseHelper.getTimeDataMapList().then((value) {
      for (var map in value) {
        timeData.add(TimeData(
          id: map["id"],
          hour: map["hour"],
          min: map["min"],
          duration: map["duration"],
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width/1.25,
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Automatic Motor"),
        actions: <Widget>[
          Center(
              child: Text(
            "Not Connected",
            style: TextStyle(fontSize: 20.0),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.remove_circle_outline,
              color: Colors.red,
            ),
          )
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            Card(
              color: Colors.blue,
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
              ),
            ),
            Container(
              //color: Colors.blue,
              child: Card(
                color: Colors.blue,
                child: ListTile(
                  title: Text(
                    "Hour Wise",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  leading: Icon(
                    Icons.hourglass_full,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ClockListData()));
                  },
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(children: <Widget>[
        Expanded(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 2.0),
          child: Container(
            //color: Colors.lightBlue,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              border: Border.all(),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 100.0, 0.0),
                      child: Text(
                        "ON Timer",
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ),
                    Text("Sec"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        height: 40,
                        width: 80,
                        child: Stack(
                          children: <Widget>[
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                              top: 3.0,
                              left: toogleValue1 == true ? 45.0 : 0.0,
                              right: toogleValue1 == true ? 0.0 : 45.0,
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      toogleValue1 = !toogleValue1;
                                    });
                                  },
                                  child: Icon(
                                    Icons.check_circle,
                                    size: 35.0,
                                    color: Colors.green,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    Text("Min")
                  ],
                ),
                Center(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: 170,
                        height: 170,
                        child: SleekCircularSlider(
                          min: 0,
                          max: 60,
                          initialValue: 1,
                          onChange: (double value1) {
                            setState(() {
                              displayTime = value1.ceil();
                            });
                          },
                          innerWidget: (double value) {
                            return null;
                          },
                        ),
                      ),
                      Container(
                          height: 170,
                          width: 170,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                displayTime.toString(),
                                style: TextStyle(fontSize: 20.0),
                              ),
                              toogleValue1 == true
                                  ? Text(
                                      "Min",
                                      style: TextStyle(fontSize: 20.0),
                                    )
                                  : Text(
                                      "Sec",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                            ],
                          ))
                    ],
                  ),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(0.0, 0.0, 100.0, 0.0),
                        child: Text(
                          "OFF Timer",
                          style: TextStyle(fontSize: 25.0),
                        ),
                      ),
                      Text("Sec"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          height: 40,
                          width: 80,
                          child: Stack(
                            children: <Widget>[
                              AnimatedPositioned(
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeIn,
                                top: 3.0,
                                left: toogleValue2 == true ? 45.0 : 0.0,
                                right: toogleValue2 == true ? 0.0 : 45.0,
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        toogleValue2 = !toogleValue2;
                                      });
                                    },
                                    child: Icon(
                                      Icons.check_circle,
                                      size: 35.0,
                                      color: Colors.green,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                      Text("Min")
                    ],
                  ),
                  Center(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: 170,
                          height: 170,
                          child: SleekCircularSlider(
                            min: 0,
                            max: 60,
                            initialValue: 1,
                            onChange: (double value1) {
                              setState(() {
                                displayTime = value1.ceil();
                              });
                            },
                            innerWidget: (double value) {
                              return null;
                            },
                          ),
                        ),
                        Container(
                            height: 170,
                            width: 170,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  displayTime.toString(),
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                toogleValue2 == true
                                    ? Text(
                                        "Min",
                                        style: TextStyle(fontSize: 20.0),
                                      )
                                    : Text(
                                        "Sec",
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        child: Text(
          "Set",
          style: TextStyle(fontSize: 22.0),
        ),
        onPressed: () {
          setState(() {
            Fluttertoast.showToast(
                msg: "Data Transmitted Succesfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0);
          });
        },
      ),
    );
  }
}
