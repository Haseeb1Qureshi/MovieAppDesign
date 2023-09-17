import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

void main() => runApp(MaterialApp(
  home: Swiping(),
));
class Swiping extends StatefulWidget {
  const Swiping({super.key});
  @override
  State<Swiping> createState() => _SwipingState();
}
class _SwipingState extends State<Swiping> {
  @override
  int activeIndex = 0;
  final urlImages = [
    "https://i.pinimg.com/originals/f1/ba/f8/f1baf83351ff26105b2d24ae95cab229.png",
    "https://venturebeat.com/wp-content/uploads/2020/06/playstation-5-side.png?fit=2000%2C1000&strip=all",
    "https://atlas-content-cdn.pixelsquid.com/stock-images/apple-airpods-pro-headphones-w7aayw5-600.jpg"
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: "Carousal_Slider".text.make(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider.builder(
                itemCount: urlImages.length,
                itemBuilder: (context, index, realIndex) {
                  return Image.network(urlImages[index]);
                },
                options: CarouselOptions(height:400,),
            ),
            AnimatedSmoothIndicator(
                activeIndex: activeIndex,
              effect: ExpandingDotsEffect(dotWidth: 10,
                activeDotColor: Colors.blue,
              ),
              count: urlImages.length,
            ),
          ],
        ),
      ),

    );
  }
}
