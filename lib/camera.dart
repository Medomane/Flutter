import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}
class _CameraPageState extends State<CameraPage> {
  File imageFile;
  VisionText visionTextOCR;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:Text('Camera'),backgroundColor: Colors.deepOrange,),
        body: Center(
          child: Column(
            children: <Widget>[
              Image(image: (imageFile == null)?AssetImage("images/photo.jpg"):FileImage(imageFile)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: (){ openDialog(context); },
                  child: Text('Pick Image',style: TextStyle(color: Colors.white,fontSize: 22),),
                )
              ),
              Container(
                height: 200,
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(child: Text('${visionTextOCR==null?'':visionTextOCR.text}', )),
              )
            ],
          ),
        )
    );
  }

  Future<VisionText> textRecognition(File imageFile){
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
    final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    final Future <VisionText> visionText = textRecognizer.processImage(visionImage);
    return visionText;
  }
  Future<void> openDialog(BuildContext context){
    var pr = new ProgressDialog(context);
    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: Text('Make a Choice'),
        actions: <Widget>[
          FlatButton(
            child: Text('Gallery'),
            onPressed: () async{
              Navigator.of(context).pop();
              var file=await ImagePicker.pickImage(source: ImageSource.gallery);
              pr.show();
              File croppedFile = await ImageCropper.cropImage(sourcePath: file.path,);
              VisionText visionText=await textRecognition(croppedFile);
              pr.hide();
              setState(() {imageFile=croppedFile;visionTextOCR=visionText;});
            },
          ),
          FlatButton(
            child: Text('Camera'),
            onPressed: () async{
              Navigator.of(context).pop();
              var file=await ImagePicker.pickImage(source: ImageSource.camera,maxWidth: 400, maxHeight: 400);
              pr.show();
              File croppedFile = await ImageCropper.cropImage(sourcePath: file.path);
              VisionText visionText=await textRecognition(croppedFile);
              pr.hide();
              setState(() { imageFile=croppedFile; visionTextOCR = visionText;});
            },
          )
        ],
      );
    });
  }
}