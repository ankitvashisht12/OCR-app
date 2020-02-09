import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr_app/result.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OCR',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File image;
  bool isImage = false;
  Future pickImage() async{
      var temp = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        image = temp;
        isImage=true;
      });
  }

  Future readText() async{
    FirebaseVisionImage fvImage = FirebaseVisionImage.fromFile(image);
    TextRecognizer recognizer = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizer.processImage(fvImage);
    String s ='';
    for (TextBlock block in readText.blocks){
      for(TextLine line in block.lines){
        s += line.text;
        s += '\n';
        
      }
    }
    
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context){
        return Result(result: s);
      })
    );
  } 

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text("Optical Character Recognizer"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          isImage ? Container(
            width: 400.0,
            height: 400.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(image),
                fit: BoxFit.cover
              )
            ),
          ) : Container(),

          SizedBox(height: 10.0,),
          RaisedButton(
            color: Colors.green,
            child: Text("Pick an Image",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),),
            onPressed: pickImage,
          ),

          

        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: readText,
        child: Icon(Icons.pageview),
        ),
   );
  }
}
