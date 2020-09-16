import 'package:animated_sliced_button/animated_sliced_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crash Button Demo',
      home: MyHomePage(title: 'Crash Widget Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              color: Colors.black,
              width: 300,
              height: 100,
              child: Text("E.U.U",style: TextStyle(color: Colors.amber,fontSize: 40),),
            ),
            SizedBox(height: 20,),
            SlicedButton(
              width: 300,
              height: 100,
              text: "NEW",

              onTap: (){
              },
            ),
            SizedBox(height: 20,),
            SlicedButton(
              width: 300,
              height: 100,

              crashDuration:Duration(milliseconds: 150),
              crashDistance: 15,

              textStyle: TextStyle(color: Colors.cyanAccent,fontSize: 30),
              text: "SLICED",

              backgroundColor: Colors.black87,
              onTap: (){
              },
            ),
            SizedBox(height: 20,),
            SlicedButton(
              width: 300,
              height: 100,

              crashDuration:Duration(milliseconds: 150),
              crashDistance: 15,

              textStyle: TextStyle(color: Colors.cyanAccent,fontSize: 30),
              text: "WIDGET",

              backgroundColor: Colors.black87,
              onTap: (){
                print("bum");
              },
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
