import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'gallery_data.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  TextEditingController keywordEditingController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Gallery'),
            backgroundColor: Colors.deepOrange
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: "Keyword"),
                controller: keywordEditingController,
                onSubmitted: (str){
                  if(check(str)){
                    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>GalleryData(str)));
                    keywordEditingController.clear();
                  }
                },
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: (){
                    var str =keywordEditingController.text ;
                    if(check(str)){
                      Navigator.of(context).push(MaterialPageRoute(builder:(context)=>GalleryData(str)));
                      keywordEditingController.clear();
                    }
                  },
                  color: Colors.deepOrange,
                  textColor: Colors.white,
                  child: Text('Get Data')
                ),
              )
            ],
          ),
        )
    );
  }
  bool check(String str){
    if(str == null || str.trim() == "") {
      Toast.show("You have to give a keyword", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      return false ;
    }
    return true ;
  }
}