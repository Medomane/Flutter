import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import './weather.dart';


class WeatherForm extends StatefulWidget {
  @override
  _WeatherFormState createState() => _WeatherFormState();
}

class _WeatherFormState extends State<WeatherForm> {
  TextEditingController cityEditingController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Weather"),
            backgroundColor: Colors.orange
        ),
        body: Column(
            children: <Widget>[
              Container(
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                          decoration: InputDecoration(hintText: 'Tape a City..'),
                          controller: cityEditingController,
                          onSubmitted: (String str){
                            if(str != null && str.trim() != ""){
                              Navigator.of(context).push(MaterialPageRoute( builder: (context)=>Weather(str)));
                              cityEditingController.text="";
                            }
                            else Toast.show("You have to give a city", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                          }
                      )
                  )
              ),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: RaisedButton(
                      child: Text('Get Weather'),
                      textColor:Colors.white ,
                      onPressed: (){
                        var str = cityEditingController.text;
                        if(str != null && str != ""){
                          Navigator.of(context).push(MaterialPageRoute( builder: (context)=>Weather(str)));
                          cityEditingController.text="";
                        }
                        else Toast.show("You have to give a city", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                      },
                      color: Colors.deepOrangeAccent
                  )
              )
            ]
        )
    );
  }
}