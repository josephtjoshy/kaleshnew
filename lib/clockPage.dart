

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/clockList.dart';
import 'package:flutter_app/data.dart';
import 'data.dart';

int durationMin = 1, durationSec = 0;

class ClockDisplay extends StatefulWidget {
  @override
  _ClockDisplayState createState() => _ClockDisplayState();
}

class _ClockDisplayState extends State<ClockDisplay> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShowClock(),
    );
  }
}

class ShowClock extends StatefulWidget {
  @override
  _ShowClockState createState() => _ShowClockState();
}

class _ShowClockState extends State<ShowClock> {
  @override
  void initState() {
    setState(() {
      isSelected = [false, false, false, false, false, false, false];
      selectedData = [0, 0, 0, 0, 0, 0, 0];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 1,
          width: MediaQuery.of(context).size.width / 1,
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 30.0, 0.0, 0.0),
                  child: ToggleButtons(
                    //splashColor: Colors.pink,
                    color: Colors.pink,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    // borderWidth: 2.0,
                    children: <Widget>[
                      Text("Mon"),
                      Text("Tue"),
                      Text("Wen"),
                      Text("Thu"),
                      Text("Fri"),
                      Text("Sat"),
                      Text("Sun"),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        for (int buttonIndex = 0;
                            buttonIndex < isSelected.length;
                            buttonIndex++) {
                          if (buttonIndex == index) {
                            if (isSelected[buttonIndex] == false) {
                              isSelected[buttonIndex] = true;
                            } else {
                              isSelected[buttonIndex] = false;
                            }
                          }

                          if (isSelected[buttonIndex] == false) {
                            selectedData[buttonIndex] = 0;
                          }
                          if (isSelected[buttonIndex] == true) {
                            selectedData[buttonIndex] = 1;
                          }
                        }
                        print(isSelected);
                        print(selectedData);
                        print(index);
                      });
                    },
                    isSelected: isSelected,
                  ),
                ),
              ),
              SizedBox(
                  height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 8.0, 0.0, 0.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "  Start:     ",
                        style: TextStyle(fontSize: 20.0, color: Colors.pink),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.pinkAccent,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0)),
                                ),
                                child: Center(
                                  child: Text("+"),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  if (hours< 23) {
                                    hours++;
                                  }
                                });
                              },
                            ),
                            Text(
                              "$hours Hr",
                              style:
                                  TextStyle(fontSize: 18.0, color: Colors.pink),
                            ),
                            GestureDetector(
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.pinkAccent,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0)),
                                ),
                                child: Center(
                                  child: Text("-"),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  if (hours > 0) {
                                    hours--;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.pinkAccent,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0)),
                                ),
                                child: Center(
                                  child: Text("+"),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  if (minutes < 59) {
                                    minutes++;
                                  }
                                });
                              },
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  "$minutes Min",
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.pink),
                                ),
                              ],
                            ),
                            GestureDetector(
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.pinkAccent,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0)),
                                ),
                                child: Center(
                                  child: Text("-"),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  if (minutes > 0) {
                                    minutes--;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 8.0, 0.0, 0.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Duration:",
                        style: TextStyle(fontSize: 20.0, color: Colors.pink),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.pinkAccent,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0)),
                                ),
                                child: Center(
                                  child: Text("+"),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  if (durationMin < 60) {
                                    durationMin = durationMin + 1;
                                  }
                                });
                              },
                            ),
                            Text(
                              "$durationMin Min",
                              style:
                                  TextStyle(fontSize: 18.0, color: Colors.pink),
                            ),
                            GestureDetector(
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.pinkAccent,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0)),
                                ),
                                child: Center(
                                  child: Text("-"),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  if (durationMin > 0) {
                                    durationMin = durationMin - 1;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.pinkAccent,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0)),
                                ),
                                child: Center(
                                  child: Text("+"),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  if (durationSec < 60) {
                                    durationSec = durationSec + 1;
                                  }
                                });
                              },
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  "$durationSec Sec",
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.pink),
                                ),
                              ],
                            ),
                            GestureDetector(
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.pinkAccent,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0)),
                                ),
                                child: Center(
                                  child: Text("-"),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  if (durationSec > 0) {
                                    durationSec = durationSec - 1;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ClockListData()));
              },
              heroTag: "hero1",
              label: Text("cancel"),
              icon: Icon(Icons.cancel),
            ),
            FloatingActionButton.extended(
              onPressed: () {
                String hourss, minutess, durationMinn, durationSecc;
                if (hours.toString().length == 1) {
                  hourss = '000';
                  hourss += hours.toString();
                }
                if (hours.toString().length == 2) {
                  hourss = '00';
                  hourss += hours.toString();
                }
                if (hours.toString().length == 3) {
                  hourss = '0';
                  hourss += hours.toString();
                }
                if (hours.toString().length == 4) {
                  hourss = hours.toString();
                }
                if (minutes.toString().length == 1) {
                  minutess = '000';
                  minutess += minutes.toString();
                }
                if (minutes.toString().length == 2) {
                  minutess = '00';
                  minutess += minutes.toString();
                }
                if (minutes.toString().length == 3) {
                  minutess = '0';
                  minutess += minutes.toString();
                }
                if (minutes.toString().length == 4) {
                  minutess = minutes.toString();
                }
                if (durationMin.toString().length == 1) {
                  durationMinn = '0';
                  durationMinn += durationMin.toString();
                }
                if (durationMin.toString().length == 2) {
                  durationMinn = durationMin.toString();
                }
                if (durationSec.toString().length == 1) {
                  durationSecc = '0';
                  durationSecc += durationSec.toString();
                }
                if (durationSec.toString().length == 2) {
                  durationSecc = durationSec.toString();
                }
                setState(() {
                  databaseHelper.insertTimeData(TimeData(
                    id: DateTime.now().toString(),
                    hour: hourss,
                    min: minutess,
                    durationmin: durationMinn,
                    durationsec: durationSecc,
                    day1: selectedData[0],
                    day2: selectedData[1],
                    day3: selectedData[2],
                    day4: selectedData[3],
                    day5: selectedData[4],
                    day6: selectedData[5],
                    day7: selectedData[6],
                  ));
                  timeData.add(TimeData(
                    id: DateTime.now().toString(),
                    hour: hourss,
                    min: minutess,
                    durationmin: durationMinn,
                    durationsec: durationSecc,
                    day1: selectedData[0],
                    day2: selectedData[1],
                    day3: selectedData[2],
                    day4: selectedData[3],
                    day5: selectedData[4],
                    day6: selectedData[5],
                    day7: selectedData[6],
                  ));
                });

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ClockListData()));
              },
              heroTag: "hero2",
              label: Text("Done"),
              icon: Icon(Icons.check_circle),
            )
          ],
        ),
      ),
    );
  }
}
