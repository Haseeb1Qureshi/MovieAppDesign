import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haseebsproject/CatalogModels.dart';
import 'package:haseebsproject/cart.dart';
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
      debugShowCheckedModeBanner: false,
      title: "CatalogApp",
      home: SplashScreen(),
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
                      "Catalog App".text.bold.indigo900.textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).xl4.make().pOnly(left: 25,top: 25),
                      "Trending Products".text.indigo900.textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make().pOnly(left: 25),
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: catalog.length,
                              itemBuilder: (context, index){
                                return Padding(
                                  padding: EdgeInsets.all(10),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Detaiing(catalog[index]),));
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
                                                child: Image.network(catalog[index].image!,)),
                                          ),
                                          SizedBox(height: 10),
                                          catalog[index].name!.text.indigo900.heightLoose.textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).bold.xl2.make(),
                                          catalog[index].desc!.text.textStyle(context.captionStyle).indigo900.make(),
                                          Container(
                                            padding: EdgeInsets.only(left: 60,right: 60),
                                            child: Row(
                                              children: [
                                                '\$${catalog[index].price!}'.text.textStyle(context.captionStyle).indigo800.bold.make().pOnly(left: 20),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              AddToCart(catalog: catalog[index],),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }else{
              return SplashScreen();
            }

          },
      ),
      floatingActionButton: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),));
        },
          child: Icon(Icons.shopping_cart,color: Colors.indigo.shade900,size: 40,).pOnly(bottom: 20,right: 10)),
    );
  }
}
class Detaiing extends StatefulWidget{
  @override

  final CatalogModels catalogs;


  Detaiing(this.catalogs);

  @override
  State<Detaiing> createState() => _DetaiingState();
}

class _DetaiingState extends State<Detaiing> {
  bool heart = false;

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        color: Color(0xfff5f5f5),
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          buttonPadding: EdgeInsets.zero,
          children: [
            '\$${widget.catalogs.price!}'.text.bold.xl2.indigo900.make(),
            IconButton(
                onPressed: (){
                  heart = heart.toggle();
                  setState(() {});
                },
                icon: heart? Icon(CupertinoIcons.heart_solid,color: Colors.red.shade900,) : Icon(CupertinoIcons.heart,color: Colors.indigo.shade900,),
            ),
          ],
        ).p(16),
      ),
      appBar: AppBar(
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.catalogs.image!),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(
              width: 10),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
              tag: Key(widget.catalogs.id.toString()),
                child: Image.network(widget.catalogs.image!)).h32(context),
            Expanded(
                child: VxArc(
                  height: 30.0,
                  arcType: VxArcType.convey,
                  edge: VxEdge.top,
                  child: Container(
                    width: context.screenWidth,
                    color: Color(0xfff5f5f5),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          widget.catalogs.name!.text.blue900.textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).bold.xl3.make(),
                          widget.catalogs.desc!.text.textStyle(context.captionStyle).xl.blue900.make(),
                          SizedBox(height: 20,),
                          Column(
                            children: [
                              Container(
                                height: 36,
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    "Camera".text.size(10).textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make().pOnly(left: 12),
                                    widget.catalogs.camera!.text.size(10).textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make().pOnly(right: 12),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                height: 36,
                                color: Colors.grey.shade300,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    "Video".text.size(10).textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make().pOnly(left: 12),
                                    widget.catalogs.video!.text.size(10).textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make().pOnly(right: 12),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                height: 36,
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    "Processor".text.size(10).textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make().pOnly(left: 12),
                                    widget.catalogs.processor!.text.size(10).textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make().pOnly(right: 12),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                height: 36,
                                color: Colors.grey.shade300,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    "Memory".text.size(10).textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make().pOnly(left: 12),
                                    widget.catalogs.memory!.text.size(10).textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make().pOnly(right: 12),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                height: 36,
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    "Battery".text.size(10).textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make().pOnly(left: 12),
                                    widget.catalogs.battery!.text.size(10).textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make().pOnly(right: 12),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                height: 36,
                                color: Colors.grey.shade300,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    "Screen".text.size(10).textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make().pOnly(left: 12),
                                    widget.catalogs.screen!.text.size(10).textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make().pOnly(right: 12),
                                  ],
                                ),
                              ),
                            ],
                          ),

                        ],
                      ).py(40),
                    ),
                  ),
                ),
            ),
          ],
        )
      ),
    );
  }
}
class AddToCart extends StatefulWidget {

  final CatalogModels catalog;

  const AddToCart({super.key, required this.catalog});
  @override
  State<AddToCart> createState() => _AddToCartState();
}
class _AddToCartState extends State<AddToCart> {
  @override
  bool isAdded = false;

  Widget build(BuildContext context) {
    return  Expanded(
      child: ElevatedButton(
        onPressed: (){
          isAdded = isAdded.toggle();
          final _catalog = CatalogModels();
          final _cart = CartModel();
          _cart.catalog = _catalog;
          _cart.addItem(widget.catalog);
          setState(() {});
        },
        child: isAdded? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.done,color: Colors.white,size: 32,),
            SizedBox(width: 5,),
            "AddedToCart".text.bold.white.make()
          ],
        ) : "Add to cart".text.white.bold.make(),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo.shade900),
      ).pOnly(left: 40,right: 40),
    );
  }
}

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState(){
    super.initState();
    Timer(Duration(seconds: 5,), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CatalogScreen(),));
    });
  }


  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "Catalog App".text.bold.textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).widest.white.xl5.make(),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                "Have Patience, please".text.textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).white.caption(context).xl.make(),
                SizedBox(width: 10,),
                SpinKitFoldingCube(color: Colors.blue.shade200,size: 22,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class CartScreen extends StatefulWidget{
  @override
  State<CartScreen> createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen>{
  @override

  Widget build(BuildContext context){
    final cart = CartModel();
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfff5f5f5),
        title: "Cart".text.make(),
      ),
      body: Column(
        children: [
          Placeholder(
            color: Color(0xfff5f5f5),
            child: CartList(),
          ).p(2).expand(),
          Divider(),
          SizedBox(height:20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              '\$${cart.totalPrice}'.text.blue900.xl2.make().pOnly(left: 20),
              ElevatedButton(
                  onPressed: (){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: "Functionality has not been added yet!".text.make(),
                      backgroundColor: Colors.indigo.shade900,
                    ),
                    );
                  },
                  child: "Buy".text.white.bold.make().pOnly(left: 15,right: 15),
                style:  ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.indigo.shade900),
                  elevation: MaterialStatePropertyAll(6),
                  shape: MaterialStatePropertyAll(ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50))),
                ),
              ).pOnly(right: 20),
            ],
          ).pOnly(bottom: 25),
        ],
      ),
    );
  }
}
class CartList extends StatefulWidget {
  @override
  State<CartList> createState() => _CartListState();
}
class _CartListState extends State<CartList> {
  @override

  final cart = CartModel();

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cart.items.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network(cart.items[index].image!),
          title: cart.items[index].name!.text.textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make(),
          subtitle: "Price: \$${cart.items[index].price}".text.blue900.textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make(),
          trailing: IconButton(
            onPressed: (){
            }, icon: Icon(Icons.remove_circle_outline),
          ),
        );
      },
    );
  }
}


