import 'package:flutter/material.dart';
import './quiz.dart';
import './weather_form.dart';
import './gallery.dart';
import './camera.dart';
import './qr_scan.dart';

class MainDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
            children: <Widget>
            [
              DrawerHeader(
                  child: Center(
                      child: CircleAvatar( radius: 50,backgroundImage: AssetImage("images/photo.jpg") )
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.orange,Colors.yellow, Colors.white]
                      )
                  )
              ),
              ListTile(
                  title: Text( 'Quiz', style: TextStyle(fontSize: 18) ),
                  trailing: Icon(Icons.live_help),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push( context, MaterialPageRoute(builder: (context) => Quiz()));
                  }
              ),
              Divider(color :Colors.black,thickness:0,),
              ListTile(
                  title: Text( 'Weather',style: TextStyle(fontSize: 18)),
                  trailing: Icon(Icons.wb_cloudy),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherForm()));
                  }
              ),
              Divider(color :Colors.black),
              ListTile(
                  title: Text( 'Gallery',style: TextStyle(fontSize: 18)),
                  trailing: Icon(Icons.art_track),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Gallery()));
                  }
              ),
              Divider(color :Colors.black),
              ListTile(
                  title: Text( 'Camera',style: TextStyle(fontSize: 18)),
                  trailing: Icon(Icons.camera),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPage()));
                  }
              ),
              Divider(color :Colors.black),
              ListTile(
                  title: Text( 'QR Scan',style: TextStyle(fontSize: 18)),
                  trailing: Icon(Icons.scanner),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => QRCodePage()));
                  }
              )
            ]
        )
    );
  }

}