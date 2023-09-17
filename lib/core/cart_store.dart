import 'package:haseebsproject/CatalogModels.dart';
import 'package:haseebsproject/cart.dart';
import 'package:velocity_x/velocity_x.dart';

class MyStore extends VxStore{

  CatalogModels catalog = CatalogModels();

  CartModel cart = CartModel();

  MyStore(){
    cart.catalog = catalog;
  }
}