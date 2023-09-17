import 'dart:async';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haseebsproject/CatalogModels.dart';
import 'package:haseebsproject/cart.dart';
import 'package:haseebsproject/core/cart_store.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(VxState(
    store: MyStore(),
      child: MyApp()));
  // without State Management.
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
      bottomNavigationBar: Container(
        height: 55,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    SystemNavigator.pop();
                  },
                    child: Icon(CupertinoIcons.fullscreen_exit,size: 28,color: Colors.indigo.shade900)),
                "exit".text.size(13).textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CatalogScreen(),));
                  },
                    child: Icon(FontAwesomeIcons.home,size: 28,color: Colors.indigo.shade900)),
                "home".text.size(11).textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),));
                  },
                    child: Icon(FontAwesomeIcons.cartShopping,size: 28,color: Colors.indigo.shade900,)),
                "cart".text.size(12).textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make(),
              ],
            )
          ],
        ),
      ).pOnly(top: 5),
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
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Detaiing(catalog[index]),));
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
            AddToCart(catalog: widget.catalogs)
          ],
        ).p(16),
      ),
      appBar: AppBar(
        actions: [
          Image.network(widget.catalogs.image!),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Hero(
                tag: Key(widget.catalogs.id.toString()),
                child: Container(
                  child: PageStorage(
                    bucket: PageStorageBucket(),
                    child: CarouselSlider.builder(
                      itemCount: widget.catalogs.pictures!.length,
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 2),
                        autoPlayAnimationDuration: Duration(seconds: 2),
                        autoPlayCurve: Curves.easeInOut
                      ),
                      itemBuilder: (context, i, id) {
                        return GestureDetector(
                          child: FullScreenWidget(
                            backgroundColor: Colors.white,
                            disposeLevel: DisposeLevel.High,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRect(
                                child: Image.network(widget.catalogs.pictures![i]),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
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
                          ).pOnly(top: 35),

                        ],
                      ).py(40),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}
class AddToCart extends StatelessWidget {
  @override
  final CatalogModels catalog;
  AddToCart({super.key, required this.catalog});

  Widget build(BuildContext context) {
    VxState.watch(context, on: [AddMutation, RemoveMutation]);

    final CartModel _cart = (VxState.store as MyStore).cart;

    bool isinCart = _cart.itemsids.contains(catalog)?? false;
    return  Expanded(
      child: ElevatedButton(
          onPressed: (){
            if(!isinCart) {
              AddMutation(catalog);
            }
          },
          child: isinCart? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.done,color: Colors.white,size: 32,),
              SizedBox(width: 5,),
              "AddedToCart".text.bold.textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).white.make()
            ],
          ) : "Add to cart".text.white.textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).bold.make(),
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.indigo.shade900),
            minimumSize: MaterialStatePropertyAll(Size(30, 50)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          )
      ).pOnly(top: 5),
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

    final CartModel cart = (VxState.store as MyStore).cart;

    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfff5f5f5),
        title: "Cart".text.textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make(),
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
              VxConsumer(
                mutations: {RemoveMutation},
                  builder: (context, store, status) {
                    return  '\$${cart.totalPrice}'.text.blue900.xl2.make().pOnly(left: 20);
                  },
              ),
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
class CartList extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    VxState.watch(context, on: [RemoveMutation]);
    final CartModel cart = (VxState.store as MyStore).cart;

    return cart.itemsids!.isEmpty? "You have not added any product to the cart yet!".text.size(10).
    textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).makeCentered() :
    ListView.builder(
      itemCount: cart.itemsids.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Container(
                  child: PageStorage(
                    bucket: PageStorageBucket(),
                    child: CarouselSlider.builder(
                      itemCount:cart.itemsids[index].pictures!.length,
                      options: CarouselOptions(
                        reverse: true,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 2),
                          autoPlayAnimationDuration: Duration(seconds: 2),
                          autoPlayCurve: Curves.easeInOut
                      ),
                      itemBuilder: (context, i, id) {
                        return GestureDetector(
                          child: Container(
                            child: ClipRect(
                              child: Image.network(cart.itemsids[index].pictures![i]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
          title: cart.itemsids[index].name!.text.textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make(),
          subtitle: "Price: \$${cart.itemsids[index].price}".text.blue900.textStyle(TextStyle(fontFamily: GoogleFonts.poppins().fontFamily)).make(),
          trailing: IconButton(
            onPressed: (){
              RemoveMutation(cart.itemsids[index]);
              
            }, icon: Icon(Icons.remove_circle_outline),
          ),
        );
      },
    );
  }
}


