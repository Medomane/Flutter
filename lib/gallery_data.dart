import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_downloader/image_downloader.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'dart:convert';

import 'package:transparent_image/transparent_image.dart';

class GalleryData extends StatefulWidget {
  final String keyword;
  GalleryData(this.keyword);
  @override
  _GalleryDataState createState() => _GalleryDataState();
}

class _GalleryDataState extends State<GalleryData> {
  List<dynamic> data;
  int currentPage=1, perPage=20, totalPages=0;
  ScrollController _scrollController=new ScrollController();
  dynamic dataGallery;
  List<dynamic> hits=new List();
  bool loading = false ;
  @override
  void initState() {
    super.initState();
    getData("https://pixabay.com/api/?key=5832566-81dc7429a63c86e3b707d0429&q=${widget.keyword}&page=$currentPage&per_page=$perPage");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('${widget.keyword} : $currentPage/$totalPages'),
            backgroundColor: Colors.orange
        ),
        body: hits.length == 0 ?
        Center(child: CircularProgressIndicator()):
        ListView.builder(
            itemCount: perPage*currentPage,
            controller: _scrollController,
            itemBuilder: (context, index) {
              return (index >= hits.length-1 )?
                Column(
                  children: <Widget>[
                    item(hits.length-1),
                    new MaterialButton(
                      child: setUpButtonChild(),
                      onPressed: () {
                        if (!loading) {
                          setState(() {
                            if(currentPage<=totalPages){
                              loading = true ;
                              currentPage++;
                              getData("https://pixabay.com/api/?key=5832566-81dc7429a63c86e3b707d0429&q=${widget.keyword}&page=$currentPage&per_page=$perPage");
                            }
                          });
                        }
                      },
                      elevation: 4.0,
                      minWidth: double.infinity,
                      height: 48.0,
                      color: Colors.lightGreen,
                    ),
                  ],
                )
               : item(index);
            }
        )
    );
  }

  @override void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Column item(int index){
    var pr = new ProgressDialog(context);
    return Column(
      children: <Widget>[
        Card(
            color: Colors.black,
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('${hits[index]["tags"]}', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),textAlign: TextAlign.center)
                      ],
                    ),
                    Divider(height: 20),
                    Stack(
                      children: [
                        Center(child: CircularProgressIndicator(),heightFactor: 2),

                        GestureDetector(
                          onLongPress: () async {
                            try {
                              pr.show();
                              var imageId = await ImageDownloader.downloadImage('${hits[index]["largeImageURL"]}');
                              if (imageId == null) Toast.show("Erreur", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                              else Toast.show("Image downloaded successfully", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor: Colors.white,textColor: Colors.black);
                              pr.hide();
                            } catch (error) {
                              print(error.toString());
                              pr.hide();
                            }
                          },
                          child:Center(
                              child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: '${hits[index]["largeImageURL"]}'
                              )
                          ),
                        ),
                      ],
                    )
                  ]
                )
            )
        )
      ]
    );
  }

  getData(url){
    http.get(Uri.encodeFull(url), headers: {'accept': 'application/json'}).then((resp){
      setState(() {
        dataGallery=json.decode(resp.body);
        hits.addAll(dataGallery['hits']);
        if(dataGallery['totalHits']%this.perPage==0) this.totalPages=dataGallery['totalHits']~/this.perPage;
        else this.totalPages=1+(dataGallery['totalHits']/this.perPage).floor();
        loading = false ;
      });
    }).catchError((err){
      print("error : "+err.toString());
    });
  }

  Widget setUpButtonChild() {
    if (!loading) {
      return new Text(
        "Load more",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    }
    else{
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    }
  }
}