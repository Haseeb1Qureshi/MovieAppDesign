import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

void main () => runApp(MaterialApp(
  title: "CounterApp",
  home: CounterScreen(),
));
class CounterScreen extends StatefulWidget{
  @override
  State<CounterScreen> createState() => _CounterScreen();
}
class _CounterScreen extends State<CounterScreen>{
  @override

  var count = 0;

  void incremet(){
    count++;
      setState(() {});
    }
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: count <100? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: count < 10? Colors.white
            : count <20? Colors.blue.shade50 : count < 30? Colors.blue.shade100
            : count <40? Colors.blue.shade200 : count <50? Colors.blue.shade300
            :count <60? Colors.blue.shade400 : count <70? Colors.blue.shade500
            : count <80? Colors.blue.shade600 : count <90? Colors.blue.shade700
            : count <100? Colors.blue.shade800 : Colors.red.shade900,
        title: count<100? "CounterApp".text.black.bold.make()
            : Center(child: "CounterApp".text.white.bold.make())
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            count<100?"Counter: $count".text.size(34).make() : "Counter: $count".text.white.size(34).make(),
            count == 0? "Tap the increment Button".text.size(17).make()
                : count < 10? "You have taped this many times".text.size(17).make()
                : count < 20? "You have taped more than 10".text.size(17).make()
                : count < 30? "You have taped more than 20".text.size(17).make()
                : count < 40? "You have taped more than 30".text.size(17).make()
                : count < 50? "You have taped more than 40".text.size(17).make()
                : count < 60? "You have taped more than 50".text.size(17).make()
                : count <70? "You have taped more than 60".text.size(17).make()
                : count <80? "You have taped more than 70".text.size(17).make()
                : count <90? "You have taped more than 80".text.size(17).make()
                : count <100? "You have taped more than 90".text.size(17).make() 
                : "You have taped more than 100".text.white.size(17).make(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed:() => incremet(),
          child: Icon(Icons.add),
        foregroundColor: count<100? Colors.black : Colors.white,
        backgroundColor: count < 10? Colors.white
            : count <20? Colors.blue.shade50 : count < 30? Colors.blue.shade100
            : count <40? Colors.blue.shade200 : count <50? Colors.blue.shade300
            :count <60? Colors.blue.shade400 : count <70? Colors.blue.shade500
            : count <80? Colors.blue.shade600 : count <90? Colors.blue.shade700
            : count <100? Colors.blue.shade800 : Colors.red.shade900,

      ),
    );
  }
}