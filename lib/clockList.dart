import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'clockPage.dart';
import 'data.dart';
Timer timer2;
class ClockListData extends StatefulWidget {
  @override
  _ClockListDataState createState() => _ClockListDataState();
}

class _ClockListDataState extends State<ClockListData> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ClockListView(),
    );
  }
}
class ClockListView extends StatefulWidget {
  @override
  _ClockListViewState createState() => _ClockListViewState();
}

class _ClockListViewState extends State<ClockListView> {

  @override
  void initState() {
    // TODO: implement initState
    timer2=Timer.periodic(Duration(seconds: 1), (timer1) {
      // print(online);
      setState(() {
        if(online==true)
        {
          online=true;
        }


      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer2.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hour Wise Control"),
        actions: <Widget>[
          Center(
              child:Text(
                online==false?"Not Connected":"Connected",
                style: TextStyle(fontSize: 20.0),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              online==false?Icons.remove_circle_outline:Icons.wifi,
              color: online==false?Colors.red:Colors.green,
            ),
          )
        ],
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: ()
          {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WorkingPage()));
          },
        ),
      ),
      body: timeData.length>0?ListView.builder(
        itemCount: timeData.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Card(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("${timeData[index].hour}:${timeData[index].min} Min",style: TextStyle(fontSize: 20,color: Colors.blue),),
                  Text("Duration : ${timeData[index].durationmin}:${timeData[index].durationsec}",style: TextStyle(fontSize: 17,color: Colors.blue),),
                ],
              ),
              subtitle: Text("${getWeeks(index)}"),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${index+1}",style: TextStyle(fontSize: 25,color: Colors.blue),
                ),
              ),
              trailing: GestureDetector(
                child: Icon(Icons.delete,color: Colors.blue,),
                onTap: ()
                {
                  setState(() {
                    //print(timeData[index]);
                    print("deleted index:${timeData[index].id}");
                    databaseHelper.deleteTime(timeData[index].id);
                    timeData.removeAt(index);
                    //print(timeData[index]);

                  });
                },
              ),
            ),
          );
        }
      ):Padding(
        padding: const EdgeInsets.fromLTRB(8.0,40.0,8.0,0.0),
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: Colors.blue),

          ),
          child: Center(
            child: ListTile(
            title: Center(child: Text("Press Add button to Add timings",style: TextStyle(fontSize: 20.0,color: Colors.blue),)),
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(30.0,0.0,0.0,0.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton.extended(
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ClockDisplay()));
                },
                heroTag: "addHero",
                label: Text("Add"),
                icon: Icon(Icons.add_circle),
              ),
              FloatingActionButton.extended(
                onPressed: ()
                {
                  if(online==true)
                    {
                      List tranmitData=[];
                      tranmitData.add("list");
                      for(int i=0;i<timeData.length;i++)
                      {
                        tranmitData.add(timeData[i].hour);
                        tranmitData.add(timeData[i].min);
                        tranmitData.add(timeData[i].durationmin);
                        tranmitData.add(timeData[i].durationsec);
                        tranmitData.add(timeData[i].day1);
                        tranmitData.add(timeData[i].day2);
                        tranmitData.add(timeData[i].day3);
                        tranmitData.add(timeData[i].day4);
                        tranmitData.add(timeData[i].day5);
                        tranmitData.add(timeData[i].day6);
                        tranmitData.add(timeData[i].day7);
                      }
                      tranmitData.add(DateTime.now().toString());
                      socketClient.write(tranmitData);
                      Fluttertoast.showToast(
                          msg: "Data Transmitted Succesfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  else
                    {
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
                heroTag: "setHero",
                label: Text("Set"),
                icon: Icon(Icons.check_circle),
              )

            ],
          ),
        ),
      ),
    );
  }
}

