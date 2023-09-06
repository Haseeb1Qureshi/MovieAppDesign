import 'CatalogModels.dart';

class CartModel {

  static final cartModel = CartModel._internal();

  CartModel._internal();

  factory CartModel() => cartModel;

  final List<CatalogModels> _items = [];

  set catalog(CatalogModels catalog) {}
  // Add an item to the cart
  void addItem(CatalogModels newItem) {
    _items.add(newItem);
  }

  // Remove an item from the cart
  void removeItem(CatalogModels itemToRemove) {
    _items.remove(itemToRemove);
  }

  // Get the list of items in the cart
  List<CatalogModels> get items => _items;
  num get totalPrice => items.fold(0, (total, current) => total + current.price!);
}
