import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'style/global.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'api.dart';
import 'dart:convert';
import 'dart:io';
import 'KEYS.dart';
import 'style/speechscreen.dart';


void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISL - TALK',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController textEditingController = new TextEditingController();
  String text;
  String url;
  var Data;
  String query;
  String sentence;


  void playYoutubeVideo(query){
    FlutterYoutube.playYoutubeVideoByUrl(apiKey: (KEY), videoUrl: query, autoPlay: true, );
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: SafeArea(
            child: new Scaffold(
                backgroundColor: c2,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: c1,
                ),
                body: Stack(
                  children: <Widget>[

                    SafeArea(
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        height: 330,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)) ,
                            color: c1
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 150),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                  children:[
                                    Text('ISL-TALK',
                                        style: newstyle1),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text('The  World  of  Signs',
                                          style: newstyle2),
                                    ),
                                  ]),

                            ],
                          ),),),),
                    Container(
                      margin: EdgeInsets.only(top: 450, left: MediaQuery.of(context).size.width*0.5 - 35),
                      child: SizedBox(
                        height: 80.0,
                        width: 80.0,
                        child: FloatingActionButton(
                          child: Icon(Icons.mic, size: 35,),
                          backgroundColor: c1,
                          foregroundColor: c2,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => speechscreen()));
                          },
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 200),
                        child:Padding(
                          padding: const EdgeInsets.fromLTRB(20,0,20,0),
                          child: TextField(
                            onChanged: (value){
                              sentence =  value.toString();
                            },
                            style: TextStyle(color: c2,fontSize: 20),
                            cursorColor: c2,
                            autofocus: false,
                            controller: textEditingController,
                            decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                      icon: Icon(Icons.search, color: c2, size: 40,),
                                      onPressed: () async {
                                        int i=0;
                                        while(sentence[i]!='\0'){
                                          url = 'http://10.0.2.2:5000/api?query=';
                                          if(sentence[i]!=' '){
                                             url += sentence[i];
                                          }
                                         else {
                                            Data = await Getdata(url);
                                            var dd = jsonDecode(Data);
                                            print(url);
                                            setState(() {
                                              query = dd['url'];
                                              playYoutubeVideo(query);
                                            });
                                            }
                                         }
                                      }
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(borderSide: new BorderSide(color: c2,width: 3,)),
                                focusedBorder: UnderlineInputBorder(borderSide: new BorderSide(color: c2,width: 3,))
                            ),
                          ),
                        )
                    ),
                  ],

                )
            )
        )
    );

  }

}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}