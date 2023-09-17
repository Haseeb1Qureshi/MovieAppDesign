import 'package:haseebsproject/core/cart_store.dart';
import 'package:velocity_x/velocity_x.dart';

import 'CatalogModels.dart';

class CartModel {

  // static final cartModel = CartModel._internal();
  //
  // CartModel._internal();
  //
  // factory CartModel() => cartModel; we did singleton over here but now we are not doing it because we are doing statement.


  final List<CatalogModels> _items = [];

  set catalog(CatalogModels catalog) {}
  // Add an item to the cart

  // Remove an item from the cart
  void removeItem(CatalogModels itemToRemove) {
    _items.remove(itemToRemove);
  }

  // Get the list of items in the cart
  List<CatalogModels> get itemsids => _items;
  num get totalPrice => itemsids.fold(0, (total, current) => total + current.price!);
}
class AddMutation extends VxMutation<MyStore>{
  @override
  final CatalogModels items;

  AddMutation(this.items);
  perform() {
    store!.cart.itemsids.add(items);
  }
}
class RemoveMutation extends VxMutation<MyStore>{
  @override
  final CatalogModels itemss;

  RemoveMutation(this.itemss);
  perform() {
    store!.cart.itemsids.remove(itemss);
  }

}
