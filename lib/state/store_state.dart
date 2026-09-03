import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';
import '../models/review.dart';
import '../data/farm_data.dart';

class StoreState extends ChangeNotifier {
  final List<CartItem> _cartItems = [];
  final Set<String> _wishlistIds = {};
  String _selectedCategory = "All";
  String _searchQuery = "";
  int _storeLikes = 64;
  bool _isStoreLiked = false;
  final List<CustomerReview> _reviews = List.from(FarmData.initialReviews);
  Product? _selectedProduct;

  List<CartItem> get cartItems => List.unmodifiable(_cartItems);
  Set<String> get wishlistIds => Set.unmodifiable(_wishlistIds);
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  int get storeLikes => _storeLikes;
  bool get isStoreLiked => _isStoreLiked;
  List<CustomerReview> get reviews => List.unmodifiable(_reviews);
  Product? get selectedProduct => _selectedProduct;

  int get cartTotalCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get deliveryFee => _cartItems.isEmpty ? 0 : (subtotal > 50000 ? 0 : 2500);

  double get grandTotal => subtotal + deliveryFee;

  List<Product> get filteredProducts {
    return FarmData.products.where((product) {
      final matchesCategory = _selectedCategory == "All" || product.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.category.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<Product> get specialsProducts {
    return FarmData.products.where((p) => p.isSpecial).toList();
  }

  List<Product> get popularProducts {
    return FarmData.products.where((p) => p.isPopular).toList();
  }

  void addToCart(Product product, {int quantity = 1, String? unit}) {
    final existingIndex = _cartItems.indexWhere((item) => item.product.id == product.id);
    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity += quantity;
    } else {
      _cartItems.add(CartItem(
        product: product,
        quantity: quantity,
        selectedUnit: unit ?? product.unit,
      ));
    }
    notifyListeners();
  }

  void decrementCartItem(String productId) {
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity -= 1;
      } else {
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeFromCart(String productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void toggleWishlist(String productId) {
    if (_wishlistIds.contains(productId)) {
      _wishlistIds.remove(productId);
    } else {
      _wishlistIds.add(productId);
    }
    notifyListeners();
  }

  bool isInWishlist(String productId) => _wishlistIds.contains(productId);

  void toggleStoreLike() {
    _isStoreLiked = !_isStoreLiked;
    _storeLikes += _isStoreLiked ? 1 : -1;
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void openProductDetail(Product? product) {
    _selectedProduct = product;
    notifyListeners();
  }

  void addReview(String author, double rating, String comment) {
    _reviews.insert(
      0,
      CustomerReview(
        id: "rev-${DateTime.now().millisecondsSinceEpoch}",
        author: author,
        rating: rating,
        comment: comment,
        date: "Just now",
      ),
    );
    notifyListeners();
  }

  // Generate WhatsApp Direct Order text link
  String generateWhatsAppOrderMessage({
    required String customerName,
    required String customerPhone,
    required String deliveryAddress,
    String? deliveryNotes,
  }) {
    final buffer = StringBuffer();
    buffer.writeln("🌾 *ORDER FROM ABIMOT FOOD & FARM PRODUCE* 🌾");
    buffer.writeln("━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
    buffer.writeln("*Customer:* $customerName");
    buffer.writeln("*Phone:* $customerPhone");
    buffer.writeln("*Delivery Address:* $deliveryAddress");
    if (deliveryNotes != null && deliveryNotes.isNotEmpty) {
      buffer.writeln("*Notes:* $deliveryNotes");
    }
    buffer.writeln("━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
    buffer.writeln("*ITEMS ORDERED:*");

    for (int i = 0; i < _cartItems.length; i++) {
      final item = _cartItems[i];
      buffer.writeln("${i + 1}. *${item.product.name}*");
      buffer.writeln("   Qty: ${item.quantity} (${item.selectedUnit}) x ₦${item.product.price.toStringAsFixed(0)} = ₦${item.totalPrice.toStringAsFixed(0)}");
    }

    buffer.writeln("━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
    buffer.writeln("*Subtotal:* ₦${subtotal.toStringAsFixed(0)}");
    buffer.writeln("*Delivery:* ${deliveryFee == 0 ? "FREE" : "₦${deliveryFee.toStringAsFixed(0)}"}");
    buffer.writeln("*TOTAL:* ₦${grandTotal.toStringAsFixed(0)}");
    buffer.writeln("━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
    buffer.writeln("Please confirm my order and send payment details. Thank you!");

    return Uri.encodeComponent(buffer.toString());
  }
}
