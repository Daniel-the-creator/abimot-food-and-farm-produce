import 'product.dart';

class CartItem {
  final Product product;
  int quantity;
  final String selectedUnit;

  CartItem({
    required this.product,
    this.quantity = 1,
    String? selectedUnit,
  }) : selectedUnit = selectedUnit ?? product.unit;

  double get totalPrice => product.price * quantity;
}
