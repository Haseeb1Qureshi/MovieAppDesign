import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  title: "MyApp",
  theme: ThemeData(primarySwatch: Colors.deepOrange),
  home: MyHomie(),
));

class MyHomie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PositionedWidget"),
      ),
      body: Container(
        color: Colors.blueGrey,
        width: 300,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              bottom: 150,
              left: 80,
              child: Container(
                height: 100,
                width: 200,
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
