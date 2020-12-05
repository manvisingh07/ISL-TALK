import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'global.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:isl_talk_v1/api.dart';
import 'dart:convert';
import 'dart:io';
import 'package:isl_talk_v1/keys.dart';

class speechscreen extends StatefulWidget {
  @override
  _speechscreenState createState() => _speechscreenState();
}

class _speechscreenState extends State<speechscreen> {

  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text =  'Start Speaking';
  String url;
  var Data;
  String query;


  void playYoutubeVideo(query){
    FlutterYoutube.playYoutubeVideoByUrl(apiKey: (KEY), videoUrl: query, autoPlay: true, );
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _listen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c2,
      appBar: AppBar(
        title: Text("Speech Screen",style: newstyle2,),
        backgroundColor: c1,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
            child: SingleChildScrollView(
            reverse: true,
            child: Padding(
            padding: const EdgeInsets.all(80.0),
            child: Text(_text, style: newstyle3,),),),),

            Padding(
            padding: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.only(top: 175,),
              child: new ButtonBar(
                mainAxisSize: MainAxisSize.min,
                buttonHeight: 50,
                children: <Widget>[
                  RaisedButton(
                    child: new Text('SERACH', style: newstyle2,),
                    color: c1,
                    onPressed: ()  async {
                      url = 'http://10.0.2.2:5000/api?query=' + _text.toString();
                      Data = await Getdata(url);
                      var dd = jsonDecode(Data);
                      setState(() {
                        query = dd['url'];
                        playYoutubeVideo(query);
                      });

                    },
                  ),
                  RaisedButton(
                    child: new Text('GO BACK', style: newstyle2),
                    color: c1,
                    onPressed: () {Navigator.pop(context);},
                  ),

                ],
              ),
            )
    )
        ]),
      ));
  }


void _listen() async {
  if (!_isListening) {
    bool available = await _speech.initialize(
      onStatus: (val) => print('onStatus: $val'),
      onError: (val) => print('onError: $val'),
    );
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(onResult: (val) => setState(() {_text = val.recognizedWords;}));
    }
  } else {
    setState(() => _isListening = false);
    _speech.stop();
  }
}
}
