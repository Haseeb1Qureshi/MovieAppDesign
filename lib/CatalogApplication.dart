import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haseebsproject/CatalogModels.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CatalogApp",
      home: CatalogScreen(),
    );
  }
}

class CatalogScreen extends StatefulWidget{
  @override
  State<CatalogScreen> createState() => _CatalogScreen();
}
class _CatalogScreen extends State<CatalogScreen>{
  @override

  void initState(){
    super.initState();
    getCatalog();
  }

  Future<List<CatalogModels>> getCatalog () async{
    await Future.delayed(Duration(seconds: 4));
    String data = await DefaultAssetBundle.of(context).loadString('assets/files/catalog.json');
    List mapData = jsonDecode(data);
    
    List<CatalogModels> catalog = mapData.map((catalog) => CatalogModels.fromJson(catalog)).toList();
    return catalog;
  }


  //colors
  // static Color creamColor = Color(0xfff5f5f5);

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: getCatalog(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              List<CatalogModels> catalog = snapshot.data!;
              return SafeArea(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Catalog App".text.bold.blue900.textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).xl4.make().pOnly(left: 25,top: 25),
                      "Trending Products".text.blue900.textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make().pOnly(left: 25),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: catalog.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Detaiing(catalogs: catalog[index])));
                                },
                                child: Card(
                                  borderOnForeground: true,
                                  shadowColor: Colors.blue.shade900,
                                  elevation: 10,
                                  color: Colors.white,
                                  child: Column(
                                    children:[
                                      Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.only(left: 50,right: 50,top: 30,bottom: 15),
                                        child: Hero(
                                          tag: Key(catalog[index].id.toString()),
                                            child: Image.network(catalog[index].image!)),
                                      ),
                                      SizedBox(height: 10),
                                      catalog[index].name!.text.blue900.heightLoose.textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).bold.xl2.make(),
                                      catalog[index].desc!.text.textStyle(context.captionStyle).blue900.make(),
                                      Container(
                                        padding: EdgeInsets.only(left: 60,right: 60),
                                        child: Row(
                                          children: [
                                            '\$${catalog[index].price!}'.text.textStyle(context.captionStyle).blue800.bold.make().pOnly(left: 20),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => Detaiing(catalogs: catalog[index])));
                                              },
                                              child: "buy".text.white.bold.make(),
                                              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900),
                                            ).pOnly(left: 40,right: 40),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }else{
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitDancingSquare(color: Colors.blue.shade900),
                    "Have a patience, please".text.blue900.make(),
                  ],
                ),
              );
            }

          },
      ),
    );
  }
}
class Detaiing extends StatelessWidget{
  @override

  final CatalogModels catalogs;

  const Detaiing({required this.catalogs});

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        color: Color(0xfff5f5f5),
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          buttonPadding: EdgeInsets.zero,
          children: [
            '\$${catalogs.price!}'.text.bold.xl2.red800.make(),
            ElevatedButton(
                onPressed: (){},
                child: "buy".text.bold.xl.white.make(),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue.shade900),
                shape: MaterialStateProperty.all(StadiumBorder()),
              ),
            ).wh(100, 40),
          ],
        ).p(16),
      ),
      appBar: AppBar(
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage(catalogs.image!),
            backgroundColor: Color(0xfff5f5f5),
          ),
          SizedBox(
              width: 10),
        ],
        backgroundColor: Color(0xfff5f5f5),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
              tag: Key(catalogs.id.toString()),
                child: Image.network(catalogs.image!)).h32(context),
            Expanded(
                child: VxArc(
                  height: 30.0,
                  arcType: VxArcType.convey,
                  edge: VxEdge.top,
                  child: Container(
                    width: context.screenWidth,
                    color: Color(0xfff5f5f5),
                    child: Column(
                      children: [
                        catalogs.name!.text.blue900.textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).bold.xl3.make(),
                        catalogs.desc!.text.textStyle(context.captionStyle).xl.blue900.make(),
                      ],
                    ).py64(),
                  ),
                ),
            ),
          ],
        )
      ),
    );
  }
}

