import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/main.dart';

import 'clockPage.dart';
import 'data.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hour Wise Control"),
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
                  socketClient.write('helo');
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

