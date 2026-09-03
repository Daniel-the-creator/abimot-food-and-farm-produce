import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../state/store_state.dart';
import '../data/farm_data.dart';
import '../models/product.dart';

class WishlistDrawer extends StatelessWidget {
  final StoreState state;
  final Function(Product) onOpenProductDetail;

  const WishlistDrawer({
    super.key,
    required this.state,
    required this.onOpenProductDetail,
  });

  @override
  Widget build(BuildContext context) {
    // Get all wishlisted products
    final wishlistedProducts = FarmData.products
        .where((p) => state.isInWishlist(p.id))
        .toList();

    return Container(
      width: MediaQuery.of(context).size.width > 480 ? 420 : MediaQuery.of(context).size.width,
      color: AppTheme.cardBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drawer Header
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.favorite, color: AppTheme.saleRed, size: 22),
                      const SizedBox(width: 8),
                      Text(
                        "Your Wishlist (${wishlistedProducts.length})",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppTheme.textMuted),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ),

          const Divider(height: 1, color: AppTheme.cardBorder),

          // Drawer Body
          Expanded(
            child: wishlistedProducts.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 68,
                            height: 68,
                            decoration: BoxDecoration(
                              color: AppTheme.cardBgElevated,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppTheme.cardBorder),
                            ),
                            child: const Icon(
                              Icons.favorite_border,
                              size: 32,
                              color: AppTheme.textMuted,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Your Wishlist is Empty",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Tap the heart ♡ icon on any farm produce to save your favorite items here for quick access.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12.5, color: AppTheme.textMuted, height: 1.4),
                          ),
                          const SizedBox(height: 18),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.gold,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text("Explore Produce", style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    itemCount: wishlistedProducts.length,
                    separatorBuilder: (context, index) => const Divider(color: AppTheme.cardBorder, height: 16),
                    itemBuilder: (context, index) {
                      final product = wishlistedProducts[index];

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          onOpenProductDetail(product);
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Thumbnail
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppTheme.cardBorder),
                                image: DecorationImage(
                                  image: NetworkImage(product.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            // Product Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.brand.toUpperCase(),
                                    style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: AppTheme.gold),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    product.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        "₦${product.price.toStringAsFixed(0)}",
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.gold,
                                        ),
                                      ),
                                      if (product.originalPrice > product.price) ...[
                                        const SizedBox(width: 6),
                                        Text(
                                          "₦${product.originalPrice.toStringAsFixed(0)}",
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: AppTheme.textMuted,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 8),

                            // Action buttons: Add to Cart & Remove
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    state.addToCart(product);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 2),
                                        backgroundColor: AppTheme.cardBgElevated,
                                        content: Text(
                                          "Added ${product.name} to cart!",
                                          style: const TextStyle(color: AppTheme.textPrimary),
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.cardBgElevated,
                                    foregroundColor: AppTheme.textPrimary,
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    side: const BorderSide(color: AppTheme.cardBorder),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    elevation: 0,
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.add_shopping_cart, size: 14, color: AppTheme.gold),
                                      SizedBox(width: 4),
                                      Text("Add", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                InkWell(
                                  onTap: () => state.toggleWishlist(product.id),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    child: Text(
                                      "Remove",
                                      style: TextStyle(fontSize: 10.5, color: AppTheme.saleRed),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // Drawer Footer (Add All to Cart)
          if (wishlistedProducts.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppTheme.cardBgElevated,
                border: Border(
                  top: BorderSide(color: AppTheme.cardBorder, width: 1),
                ),
              ),
              child: SafeArea(
                top: false,
                child: SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      for (final prod in wishlistedProducts) {
                        state.addToCart(prod);
                      }
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppTheme.cardBgElevated,
                          content: Text(
                            "Added all ${wishlistedProducts.length} wishlist items to cart!",
                            style: const TextStyle(color: AppTheme.emerald, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_bag_outlined, size: 18),
                    label: const Text("Add All Wishlist Items to Cart"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.gold,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      textStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
