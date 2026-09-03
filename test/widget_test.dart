import 'package:flutter_test/flutter_test.dart';
import 'package:abimot/state/store_state.dart';
import 'package:abimot/data/farm_data.dart';

void main() {
  group('Abimot Store State Tests', () {
    test('initial state has products and reviews', () {
      final state = StoreState();
      expect(state.cartItems, isEmpty);
      expect(state.filteredProducts.length, FarmData.products.length);
      expect(state.reviews, isNotEmpty);
      expect(state.storeLikes, 64);
    });

    test('add to cart and calculate totals', () {
      final state = StoreState();
      final product = FarmData.products.first;

      state.addToCart(product, quantity: 2);
      expect(state.cartTotalCount, 2);
      expect(state.subtotal, product.price * 2);

      // Decrement item
      state.decrementCartItem(product.id);
      expect(state.cartTotalCount, 1);
      expect(state.subtotal, product.price);

      // Remove from cart
      state.removeFromCart(product.id);
      expect(state.cartTotalCount, 0);
      expect(state.subtotal, 0.0);
    });

    test('search and category filtering', () {
      final state = StoreState();
      
      // Filter by category
      state.setSelectedCategory("Fresh Vegetables");
      expect(
        state.filteredProducts.every((p) => p.category == "Fresh Vegetables"),
        isTrue,
      );

      // Filter by search query
      state.setSelectedCategory("All");
      state.setSearchQuery("Yam");
      expect(
        state.filteredProducts.every(
          (p) => p.name.toLowerCase().contains("yam") || p.description.toLowerCase().contains("yam"),
        ),
        isTrue,
      );
    });

    test('wishlist and like toggling', () {
      final state = StoreState();
      final prodId = FarmData.products.first.id;

      expect(state.isInWishlist(prodId), isFalse);
      state.toggleWishlist(prodId);
      expect(state.isInWishlist(prodId), isTrue);
      state.toggleWishlist(prodId);
      expect(state.isInWishlist(prodId), isFalse);

      expect(state.isStoreLiked, isFalse);
      state.toggleStoreLike();
      expect(state.isStoreLiked, isTrue);
      expect(state.storeLikes, 65);
    });

    test('generate WhatsApp order message contains proper formatting', () {
      final state = StoreState();
      state.addToCart(FarmData.products[0], quantity: 2);

      final message = state.generateWhatsAppOrderMessage(
        customerName: "Bolanle Ade",
        customerPhone: "08012345678",
        deliveryAddress: "Lekki Phase 1",
      );

      expect(message, isNotEmpty);
      expect(Uri.decodeComponent(message), contains("ABIMOT FOOD & FARM PRODUCE"));
      expect(Uri.decodeComponent(message), contains("Bolanle Ade"));
      expect(Uri.decodeComponent(message), contains("Lekki Phase 1"));
    });
  });
}
