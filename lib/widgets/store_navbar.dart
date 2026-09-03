import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../state/store_state.dart';
import '../data/farm_data.dart';

class StoreNavbar extends StatelessWidget {
  final StoreState state;
  final VoidCallback onOpenCart;
  final VoidCallback onOpenWishlist;
  final VoidCallback onOpenMenu;
  final VoidCallback onScrollToProduce;
  final VoidCallback onScrollToSpecials;
  final VoidCallback onScrollToPopular;
  final VoidCallback onScrollToReviews;
  final VoidCallback onScrollToContact;

  const StoreNavbar({
    super.key,
    required this.state,
    required this.onOpenCart,
    required this.onOpenWishlist,
    required this.onOpenMenu,
    required this.onScrollToProduce,
    required this.onScrollToSpecials,
    required this.onScrollToPopular,
    required this.onScrollToReviews,
    required this.onScrollToContact,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.background.withValues(alpha: 0.92),
        border: const Border(
          bottom: BorderSide(color: AppTheme.cardBorder, width: 1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Main Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Brand Lockup
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.cardBorder),
                          image: const DecorationImage(
                            image: NetworkImage(
                              "https://images.unsplash.com/photo-1597362925123-77861d3fbac7?q=80&w=200&auto=format&fit=crop",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Abimot",
                                style: GoogleFonts.cormorantGaramond(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.textPrimary,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(width: 4),
                              // Blue Verified Seal
                              Container(
                                padding: const EdgeInsets.all(1.5),
                                decoration: const BoxDecoration(
                                  color: AppTheme.verifiedBlue,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  size: 11,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          if (isTablet)
                            Text(
                              FarmData.storeDomain,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppTheme.textMuted,
                                letterSpacing: 0.2,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 20),

                // Search Bar (Desktop / Tablet)
                if (isTablet)
                  Expanded(
                    child: Container(
                      height: 40,
                      constraints: const BoxConstraints(maxWidth: 420),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppTheme.cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppTheme.cardBorder),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, size: 18, color: AppTheme.textMuted),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              onChanged: state.setSearchQuery,
                              style: const TextStyle(fontSize: 13, color: AppTheme.textPrimary),
                              decoration: const InputDecoration(
                                hintText: "Search fresh produce, yams, poultry…",
                                hintStyle: TextStyle(fontSize: 13, color: AppTheme.textMuted),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                            ),
                          ),
                          if (state.searchQuery.isNotEmpty)
                            GestureDetector(
                              onTap: () => state.setSearchQuery(""),
                              child: const Icon(Icons.close, size: 16, color: AppTheme.textMuted),
                            ),
                        ],
                      ),
                    ),
                  )
                else
                  const Spacer(),

                if (isTablet) const Spacer(),

                // Action Icons (Wishlist & Cart & Mobile Menu)
                Row(
                  children: [
                    // Wishlist icon
                    IconButton(
                      tooltip: "Wishlist (${state.wishlistIds.length})",
                      onPressed: onOpenWishlist,
                      icon: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            state.wishlistIds.isEmpty ? Icons.favorite_border : Icons.favorite,
                            color: state.wishlistIds.isEmpty ? AppTheme.textSecondary : AppTheme.saleRed,
                            size: 22,
                          ),
                          if (state.wishlistIds.isNotEmpty)
                            Positioned(
                              top: -4,
                              right: -6,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: AppTheme.saleRed,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  "${state.wishlistIds.length}",
                                  style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 4),

                    // Shopping Cart button
                    InkWell(
                      onTap: onOpenCart,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.cardBgElevated,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: state.cartTotalCount > 0 ? AppTheme.gold : AppTheme.cardBorder,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.shopping_bag_outlined, size: 19, color: AppTheme.gold),
                            const SizedBox(width: 6),
                            Text(
                              "${state.cartTotalCount}",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            if (isDesktop && state.subtotal > 0) ...[
                              const SizedBox(width: 8),
                              Container(
                                width: 1,
                                height: 14,
                                color: AppTheme.cardBorder,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "₦${state.subtotal.toStringAsFixed(0)}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.gold,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                    if (!isDesktop) ...[
                      const SizedBox(width: 6),
                      IconButton(
                        icon: const Icon(Icons.menu, color: AppTheme.textPrimary),
                        onPressed: onOpenMenu,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // Mobile Search input when screen is small
          if (!isTablet)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppTheme.cardBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.cardBorder),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, size: 17, color: AppTheme.textMuted),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        onChanged: state.setSearchQuery,
                        style: const TextStyle(fontSize: 12.5, color: AppTheme.textPrimary),
                        decoration: const InputDecoration(
                          hintText: "Search produce, yams, poultry…",
                          hintStyle: TextStyle(fontSize: 12.5, color: AppTheme.textMuted),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Desktop Glassmorphism Navigation Bar
          if (isDesktop)
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF13151D).withValues(alpha: 0.8),
                border: const Border(
                  top: BorderSide(color: AppTheme.cardBorder, width: 0.8),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
              child: Row(
                children: [
                  _NavLink(title: "Home", isActive: true, onTap: () {}),
                  _NavLink(title: "Produce Catalog", onTap: onScrollToProduce),
                  _NavLink(title: "Today's Specials", onTap: onScrollToSpecials),
                  _NavLink(title: "Popular Harvests", onTap: onScrollToPopular),
                  _NavLink(title: "Customer Reviews", onTap: onScrollToReviews),
                  _NavLink(title: "Order & Contact", onTap: onScrollToContact),
                  
                  const Spacer(),

                  // Farm Produce Counter Pill
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.emeraldMuted,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.emerald.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        const Text("🌱 Fresh Produce", style: TextStyle(fontSize: 11, color: AppTheme.emerald, fontWeight: FontWeight.w600)),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(
                            color: AppTheme.emerald,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "${state.filteredProducts.length}",
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.title,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              color: isActive ? AppTheme.gold : AppTheme.textSecondary,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
