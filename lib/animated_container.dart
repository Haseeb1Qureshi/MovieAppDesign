import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

void main() => runApp(MaterialApp(
  title: "AnimatedContainer",
  home: AnimatedContainerScreen(),
));
class AnimatedContainerScreen extends StatefulWidget {
  const AnimatedContainerScreen({super.key});
  @override
  State<AnimatedContainerScreen> createState() => _AnimatedContainerScreenState();
}
class _AnimatedContainerScreenState extends State<AnimatedContainerScreen> {
  @override

  var _height = 100.0;
  var _width = 200.0;
  bool animate = true;

  BoxDecoration radius = BoxDecoration(
    borderRadius: BorderRadius.circular(2),
    color: Colors.blueGrey,
  );

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: "AnimatedContainer".text.white.make(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                setState(() {
                  if(animate){
                    _width = 200.0;
                    _height = 100.0;
                    radius = BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.blueGrey
                    );
                    animate = false;
                  }else {
                    _width = 100.0;
                    _height = 200.0;
                    radius = BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blueAccent
                    );
                    animate = true;
                  }
                });
              },
              child: AnimatedContainer(
                  duration: Duration(seconds: 2),
                height: _height,
                width: _width,
                decoration: radius,
                curve: Curves.elasticOut,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
