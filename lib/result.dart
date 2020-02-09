import 'package:flutter/material.dart';

class Result extends StatelessWidget {

  final String result;

  Result({Key key, @required this.result}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: 
        Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10,),
          Text('Detected Text',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              ), 
           ),
          Divider(color: Colors.grey,),
          SizedBox(height: 10.0,),
          SingleChildScrollView(
              child: Container(
              child: Center(
                child: Text(
                  '$result',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
    ),
    
    );
  }
}