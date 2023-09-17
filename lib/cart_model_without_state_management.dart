import 'CatalogModels.dart';

class CartModeltwo {

  static final cartModels = CartModeltwo._internal();

  CartModeltwo._internal();

  factory CartModeltwo() => cartModels;

  final List<CatalogModels> _ilists = [];

  set catalog(CatalogModels catalog) {}
  // Add an item to the cart
  void addItem(CatalogModels newItem) {
    _ilists.add(newItem);
  }

  // Remove an item from the cart
  void removeItem(CatalogModels itemToRemove) {
    _ilists.remove(itemToRemove);
  }

  // Get the list of items in the cart
  List<CatalogModels> get ilists => _ilists;
  num get totalPrice => ilists.fold(0, (total, current) => total + current.price!);
}
