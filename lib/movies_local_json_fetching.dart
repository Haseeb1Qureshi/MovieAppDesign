import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:haseebsproject/moviesModel.dart';
import 'package:velocity_x/velocity_x.dart';

void main() => runApp(MaterialApp(
  title: "LocalJson",
  home: MyMovies(),
  debugShowCheckedModeBanner: false,
));
class MyMovies extends StatefulWidget {
  const MyMovies({super.key});
  @override
  State<MyMovies> createState() => _MyMoviesState();
}
class _MyMoviesState extends State<MyMovies> {
  @override

  void exitButton(){
    SystemNavigator.pop();
  }
    Future<List<Movies>> getMoviesApi () async {
    await Future.delayed(Duration(seconds: 2));
    String data = await DefaultAssetBundle.of(context).loadString('assets/files/movies.json');
    List mapData = jsonDecode(data);

    List<Movies> movies = mapData.map((movie) => Movies.fromJson(movie)).toList();

    return movies;
  }
  @override
  void initState() {
    getMoviesApi();
    super.initState();

  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade400,
        centerTitle: true,
        title: "Draplinx".text.bold.make(),
      ),
      body: FutureBuilder(
          future: getMoviesApi(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              List<Movies> movies = snapshot.data!;
              return ListView.builder(
                itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(movie: movies[index])));
                      },

                      child: ListTile(
                        leading: Container(
                          width: 90,
                            height: 150,
                            child: Image.network(movies[index].poster!,fit: BoxFit.fill,)),
                        subtitle: movies[index].genre!.text.gray300.make(),
                        title: movies[index].title!.text.white.make(),
                        trailing: movies[index].runtime!.text.white.bold.make(),
                      ).pOnly(bottom: 15),
                    );
                  },
              );
            } else {
              return Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.tealAccent),
                  "Hold on a second...".text.teal200.make(),
                  SizedBox(width: 20),
                ],
              ));
            }
          },
      ),
      drawer: Drawer(
        backgroundColor: Colors.teal.shade500,
        width: 230,
        elevation: 10,
        surfaceTintColor: Colors.black,
        shadowColor: Colors.teal.shade500,
        child: DrawerHeader(
          child: Column(
            children: [
              Row(children: [
              CircleAvatar(child: "Haseeb"[0].text.teal300.bold.size(20).make(),
                backgroundColor: Colors.black,
                minRadius: 25,
              ),
              ]
              ),
              "haseebqureshi836@gmail.com".text.bold.size(13).make(),
              SizedBox(height: 600),
              Row(
                children: [
                Expanded(
                  child: ElevatedButton(onPressed: () => exitButton(),
                      child: "EXIT".text.teal300.bold.make(),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  ),
                ),
              ],)
            ],
          ),
        ),
      ),

    );
  }
}
class DetailPage extends StatefulWidget {
  final Movies movie;

   DetailPage({required this.movie});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override

  bool taping = false;
  bool buttonTaping = false;
  bool heartIcon = false;
  bool commentIcon = false;
  bool shareIcon = false;

  void iconTap(){
    taping = true;
    setState(() {});
  }
  void buttonTap(){
    buttonTaping = true;
    setState(() {});
  }
   void heartIconMethod(){
    heartIcon = true;
    setState(() {});
   }
   void commentingIcon(){
    commentIcon = true;
    setState(() {});
   }
   void sharingIcon(){
    shareIcon = true;
    setState(() {});
   }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.teal.shade300),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                ColorFiltered(
                    child: Container(
                      width: double.infinity,
                        height: 450,
                        child: Image.network(widget.movie.poster!,fit: BoxFit.fill)),
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                ),
                Positioned(
                  left: 150,
                    top: 180,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () => iconTap(),
                        child: taping? Icon(CupertinoIcons.play_circle_fill,color: Colors.teal.shade600,size: 60)
                            : Icon(CupertinoIcons.play_circle,color: Colors.teal.shade600,size: 60),
                    ),
                ),
              ],
            ),
            Row(
              children: [
                "Description:".text.size(18).teal600.bold.make().pOnly(left: 12),
              ],
            ),
            widget.movie.desc!.text.size(14).gray400.make().pOnly(left: 10,right: 10),
            Row(
              children: [
                "Genre: ".text.bold.teal600.make().pOnly(left: 12),
                widget.movie.genre!.text.size(12).bold.gray400.make()
              ],
            ),
            Row(
              children: [
                "Year: ".text.bold.teal600.make().pOnly(left: 12),
                widget.movie.year!.text.gray400.bold.make(),
              ],
            ),
            Row(
              children: [
                // SizedBox(height: 80),
                Expanded(
                  child: ElevatedButton(
                    onPressed: buttonTap,
                    child: buttonTaping? "Unable to Watch".text.bold.black.make() : "Watch".text.black.bold.make(),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal.shade700,
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => buttonTap(),
                    child: buttonTaping? "Work in Progress".text.bold.black.make() : "Add to favourites".text.black.bold.make(),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal.shade700,
                    ),
                  ),
                ),

              ],
            ),
            Row(
              children: [
                SizedBox(width: 12),
                InkWell(
                    borderRadius: BorderRadius.circular(200),
                  splashColor: Colors.black,
                  onDoubleTap: () => heartIconMethod(),
                  onTap: heartIconMethod,
                    child: heartIcon? Icon(CupertinoIcons.heart_fill,color: Colors.red.shade900)
                        : FaIcon(FontAwesomeIcons.heart,color: Colors.grey.shade500)),
                SizedBox(width: 12),
                InkWell(
                    borderRadius: BorderRadius.circular(200),
                  splashColor: Colors.black,
                  onTap: () => commentingIcon(),
                    child: commentIcon? Icon(Icons.comment_bank_rounded,color: Colors.grey.shade400,)
                        :FaIcon(FontAwesomeIcons.comment,color: Colors.grey.shade500)),
                SizedBox(width: 12),
                InkWell(
                  borderRadius: BorderRadius.circular(200),
                  splashColor: Colors.black,
                  onTap: () => sharingIcon(),
                    child: shareIcon? FaIcon(FontAwesomeIcons.shareNodes,color: Colors.grey.shade400,)
                        : FaIcon(FontAwesomeIcons.share,color: Colors.grey.shade500,)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
