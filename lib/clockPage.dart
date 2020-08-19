import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/clockList.dart';
import 'package:flutter_app/data.dart';
//import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as range;

//import 'dart:io';
import 'data.dart';
double _lowerValue = 1;


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
    // TODO: implement initState
  setState(() {
    isSelected=[false,false,false,false,false,false,false];
    selectedData=[0,0,0,0,0,0,0];
  });
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height/1,
              width: MediaQuery.of(context).size.width/1,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0,30.0,0.0,0.0),
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

                            for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                              if (buttonIndex == index) {
                                if(isSelected[buttonIndex]==false)
                                  {
                                    isSelected[buttonIndex]=true;
                                  }
                                else{
                                  isSelected[buttonIndex]=false;
                                }
                              }

                              if(isSelected[buttonIndex]==false)
                              {
                                selectedData[buttonIndex]=0;
                              }
                              if(isSelected[buttonIndex]==true)
                              {
                                selectedData[buttonIndex]=1;
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
                  Container(
                    height: MediaQuery.of(context).size.height/1.5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50.0,8.0,0.0,0.0),
                      child: Row(
                        children: <Widget>[
                          Text("Duration:",style: TextStyle(fontSize: 20.0,color: Colors.pink),),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(50.0,0.0,0.0,0.0),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  child: Container(
                                    width: 40,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color:Colors.pinkAccent,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
                                    ),
                                    child:Center(child:Text("+") ,),
                                  ),
                                  onTap: ()
                                  {
                                    print("pressed");
                                  },
                                ),
                                Text("Min",style: TextStyle(fontSize: 20.0,color: Colors.pink),),
                                GestureDetector(
                                  child: Container(
                                    width: 40,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color:Colors.pinkAccent,
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20.0)),
                                    ),
                                    child:Center(child:Text("-") ,),
                                  ),
                                  onTap: ()
                                  {
                                    print("pressed");
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(50.0,0.0,0.0,0.0),
                            child: Column(
                              children: <Widget>[
                                Text("Sec",style: TextStyle(fontSize: 20.0,color: Colors.pink),),
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
          Center(
            child: Container(
              height: 350,
              width: 350,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 350,
                      width: 350,
                      child: SleekCircularSlider(
                        initialValue: 1,
                        max: 23,
                        min: 0,
                        onChange: (double value)
                        {
                          setState(() {
                            hours=value.ceil();
                          });
                        },
                        innerWidget: (double value)
                        {
                            return null;
                        },
                      ),
                    ),
                  ),

                ],
              ),

            ),
          ),
          Center(
            child: Container(
              height:220,
              width: 220,
              child: SleekCircularSlider(
                min: 0,
                max: 59,
                initialValue: 1,
                onChange: (double value)
                {
                  setState(() {
                    minutes=value.ceil();
                  });
                },
                innerWidget: (double value)
                {
                  return null;
                },
              ),

            ),
          ),
          Center(
              child:Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 Text("Start Time",style: TextStyle(fontSize: 30.0,color: Colors.pink)),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text("$hours:$minutes",style: TextStyle(fontSize: 40.0,color: Colors.pink),),
              ),

            ],
           ),
          ),

        ],
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton.extended(
              onPressed: ()
              {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ClockListData()));
              },
              heroTag: "hero1",
              label: Text("cancel"),
              icon: Icon(Icons.cancel),
            ),
            FloatingActionButton.extended(
              onPressed:(){
                setState(() {
                  databaseHelper.insertTimeData(
                      TimeData(
                        id:DateTime.now().toString(),
                        hour:hours,
                        min: minutes,
                        duration: _lowerValue.ceil(),
                        day1: selectedData[0],
                        day2: selectedData[1],
                        day3: selectedData[2],
                        day4: selectedData[3],
                        day5: selectedData[4],
                        day6: selectedData[5],
                        day7: selectedData[6],
                      )
                  );
                  timeData.add(
                      TimeData(
                        id: DateTime.now().toString(),
                        hour:hours,
                        min: minutes,
                        duration: _lowerValue.ceil(),
                        day1: selectedData[0],
                        day2: selectedData[1],
                        day3: selectedData[2],
                        day4: selectedData[3],
                        day5: selectedData[4],
                        day6: selectedData[5],
                        day7: selectedData[6],
                      )
                  );
                });

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ClockListData()));
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

