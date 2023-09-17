import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BMI_APP",
      home: SplashingScreen(),
    );
  }
}
class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});
  @override
  State<BmiScreen> createState() => _BmiScreenState();
}
class _BmiScreenState extends State<BmiScreen> {
  @override


  var image ='https://www.pnbmetlife.com/content/dam/pnb-metlife/images/icons/bmi-calculator/meter.png';
  var result = "";

  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inchController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade500,
        title: "BMI App".text.bold.white.make(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                "BMI".text.widest.bold.textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).orange700.xl5.make().centered(),
                Image.network(image,
                  fit: BoxFit.cover,
                ).centered().pOnly(top: 42),
              ],
            ),
            SizedBox(height: 15,),
            "Calculate BMI".text.xl3.bold.textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).orange700.make(),
            SizedBox(height: 30,),
            Row(
              children: [
                TextField(
                  controller: wtController,
                  decoration: InputDecoration(
                    label: "Enter your Weight(Kgs)".text.bold.orange600.size(5).make(),
                    prefixIcon: Icon(Icons.line_weight_outlined,color: Colors.orange.shade900,),
                  ),
                  keyboardType: TextInputType.number,
                ).pOnly(left: 20,right: 20).expand(),
                TextField(
                  controller: ftController,
                  decoration: InputDecoration(
                    label: "Enter your Height(ft)".text.bold.orange600.size(5).make(),
                    prefixIcon: Icon(Icons.height_outlined,color: Colors.orange.shade900,),
                  ),
                  keyboardType: TextInputType.number,
                ).pOnly(left: 20,right: 20).expand()
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                TextField(
                  controller: inchController,
                  decoration: InputDecoration(
                    label: "Enter your Height in Inches".text.bold.orange600.size(14).make().centered(),
                    prefixIcon: Icon(Icons.height_rounded,color: Colors.orange.shade900,size: 26,)
                  ),
                  keyboardType: TextInputType.number,
                ).pOnly(left: 85,right: 85).expand(),
              ],
            ),
            SizedBox(height: 25,),
            ElevatedButton(
                onPressed: (){
                  var wt = wtController.text.toString();
                  var ft = ftController.text.toString();
                  var inch = inchController.text.toString();

                  if(wt!="" && ft!="" && inch!=""){

                    var iwt = int.parse(wt);
                    var ift = int.parse(ft);
                    var iinch = int.parse(inch);

                    var totalInch = (ift * 12) + iinch;

                    var totalCm = totalInch * 2.54;

                    var totalMeter = totalCm/100;

                    var bmi = iwt/(totalMeter*totalMeter);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: result.text.bold.make(),
                      backgroundColor: Colors.orange.shade600,
                    ));
                    setState(() {
                      result = "Your BMI is: ${bmi.toStringAsFixed(2)}";
                    });

                  }else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: result.text.bold.make(),
                      backgroundColor: Colors.orange.shade600,
                    ));
                    setState(() {
                      result = "kindly input all the above textfields, thanks.";
                    });
                  }

                },
                child: "Calculate".text.bold.textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).white.widest.make().pOnly(left: 15,right: 15),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.orange.shade500),
                shape: MaterialStatePropertyAll(ContinuousRectangleBorder(borderRadius: BorderRadius.circular(30))),
                elevation: MaterialStatePropertyAll(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class SplashingScreen extends StatefulWidget {
  const SplashingScreen({super.key});
  @override
  State<SplashingScreen> createState() => _SplashingScreenState();
}
class _SplashingScreenState extends State<SplashingScreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BmiScreen(),));
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade200,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitWaveSpinner(color: Colors.orange.shade900,size: 100,),
            SizedBox(height: 10,),
            "BMI App is loading...".text.bold.textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).orange900.make()
          ],
        ),
      ),
    );
  }
}