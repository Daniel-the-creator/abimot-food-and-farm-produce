import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'theme/app_theme.dart';
import 'state/store_state.dart';
import 'models/product.dart';
import 'data/farm_data.dart';
import 'widgets/marquee_banner.dart';
import 'widgets/store_navbar.dart';
import 'widgets/hero_carousel.dart';
import 'widgets/trust_strip.dart';
import 'widgets/categories_bar.dart';
import 'widgets/product_card.dart';
import 'widgets/flash_deal_widget.dart';
import 'widgets/promo_banner.dart';
import 'widgets/cart_drawer.dart';
import 'widgets/product_detail_modal.dart';
import 'widgets/checkout_dialog.dart';
import 'widgets/reviews_section.dart';
import 'widgets/store_footer.dart';

void main() {
  runApp(const AbimotStoreApp());
}

class AbimotStoreApp extends StatelessWidget {
  const AbimotStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abimot Food and Farm Produce | Valerie',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const StorefrontScreen(),
    );
  }
}

class StorefrontScreen extends StatefulWidget {
  const StorefrontScreen({super.key});

  @override
  State<StorefrontScreen> createState() => _StorefrontScreenState();
}

class _StorefrontScreenState extends State<StorefrontScreen> {
  final StoreState _state = StoreState();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey _produceKey = GlobalKey();
  final GlobalKey _specialsKey = GlobalKey();
  final GlobalKey _popularKey = GlobalKey();
  final GlobalKey _reviewsKey = GlobalKey();
  final GlobalKey _footerKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    _state.dispose();
    super.dispose();
  }

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _openCartDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _openMobileNavDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _showProductDetail(Product product) {
    showDialog(
      context: context,
      builder: (ctx) => ProductDetailModal(product: product, state: _state),
    );
  }

  void _showCheckoutDialog() {
    // Close cart drawer if open
    Navigator.of(context).maybePop();
    showDialog(
      context: context,
      builder: (ctx) => CheckoutDialog(state: _state),
    );
  }

  Future<void> _launchWhatsAppChat() async {
    final url = Uri.parse("https://wa.me/${FarmData.whatsappNumber}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _state,
      builder: (context, _) {
        final screenWidth = MediaQuery.of(context).size.width;

        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: AppTheme.background,

          // Mobile Navigation Drawer
          drawer: Drawer(
            backgroundColor: AppTheme.cardBg,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color(0xFF0F1118),
                    border: Border(
                      bottom: BorderSide(color: AppTheme.cardBorder),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                image: NetworkImage(
                                  "https://images.unsplash.com/photo-1597362925123-77861d3fbac7?q=80&w=200&auto=format&fit=crop",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Abimot",
                                    style: GoogleFonts.cormorantGaramond(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.verified,
                                    size: 14,
                                    color: AppTheme.verifiedBlue,
                                  ),
                                ],
                              ),
                              const Text(
                                "abimot.com",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppTheme.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "100% Organic & Fresh Farm Direct",
                        style: TextStyle(
                          fontSize: 11.5,
                          color: AppTheme.emerald,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home_outlined,
                    color: AppTheme.gold,
                  ),
                  title: const Text("Home"),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.grass_outlined,
                    color: AppTheme.emerald,
                  ),
                  title: const Text("Produce Catalog"),
                  onTap: () {
                    Navigator.pop(context);
                    _scrollToKey(_produceKey);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.star_outline, color: Colors.amber),
                  title: const Text("Today's Specials"),
                  onTap: () {
                    Navigator.pop(context);
                    _scrollToKey(_specialsKey);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.trending_up, color: AppTheme.gold),
                  title: const Text("Popular Harvests"),
                  onTap: () {
                    Navigator.pop(context);
                    _scrollToKey(_popularKey);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.rate_review_outlined,
                    color: AppTheme.textSecondary,
                  ),
                  title: const Text("Customer Reviews"),
                  onTap: () {
                    Navigator.pop(context);
                    _scrollToKey(_reviewsKey);
                  },
                ),
                ListTile(
                  leading: const Text("💬", style: TextStyle(fontSize: 18)),
                  title: const Text("WhatsApp Farm Support"),
                  onTap: () {
                    Navigator.pop(context);
                    _launchWhatsAppChat();
                  },
                ),
              ],
            ),
          ),

          // Slide-In Cart Drawer
          endDrawer: Drawer(
            child: CartDrawer(
              state: _state,
              onProceedToCheckout: _showCheckoutDialog,
            ),
          ),

          // Floating WhatsApp Button
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _launchWhatsAppChat,
            backgroundColor: const Color(0xFF25D366),
            foregroundColor: Colors.white,
            icon: const Text("💬", style: TextStyle(fontSize: 18)),
            label: const Text(
              "WhatsApp Order",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5),
            ),
          ),

          body: Column(
            children: [
              // 1. Top Announcement Marquee Ticker
              const MarqueeBanner(),

              // 2. Classy Header & Navigation
              StoreNavbar(
                state: _state,
                onOpenCart: _openCartDrawer,
                onOpenMenu: _openMobileNavDrawer,
                onScrollToProduce: () => _scrollToKey(_produceKey),
                onScrollToSpecials: () => _scrollToKey(_specialsKey),
                onScrollToPopular: () => _scrollToKey(_popularKey),
                onScrollToReviews: () => _scrollToKey(_reviewsKey),
                onScrollToContact: () => _scrollToKey(_footerKey),
              ),

              // 3. Main Scrollable Storefront
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1320),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Cinematic Hero Section
                          HeroCarousel(
                            state: _state,
                            onExploreClick: () => _scrollToKey(_produceKey),
                          ),

                          // Trust Strip (Value Props)
                          const TrustStrip(),

                          const SizedBox(height: 12),

                          // Sidebar Widget row on large screens / Stacked on small
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                if (constraints.maxWidth >= 768) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: FlashDealWidget(state: _state),
                                      ),
                                      const SizedBox(width: 16),
                                      const Expanded(
                                        child: StoreHighlightsWidget(),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      FlashDealWidget(state: _state),
                                      const SizedBox(height: 14),
                                      const StoreHighlightsWidget(),
                                    ],
                                  );
                                }
                              },
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Category Selector Filter Chips
                          CategoriesBar(state: _state),

                          // Featured Produce Section
                          Container(
                            key: _produceKey,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 3,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppTheme.emeraldMuted,
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          child: const Text(
                                            "Fresh Harvest",
                                            style: TextStyle(
                                              fontSize: 10.5,
                                              fontWeight: FontWeight.bold,
                                              color: AppTheme.emerald,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          _state.selectedCategory == "All"
                                              ? "Featured Farm Produce"
                                              : _state.selectedCategory,
                                          style: GoogleFonts.cormorantGaramond(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.textPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (_state.selectedCategory != "All" ||
                                        _state.searchQuery.isNotEmpty)
                                      TextButton(
                                        onPressed: () {
                                          _state.setSelectedCategory("All");
                                          _state.setSearchQuery("");
                                        },
                                        child: const Text(
                                          "View all produce →",
                                          style: TextStyle(
                                            color: AppTheme.gold,
                                            fontSize: 12.5,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                // Responsive Grid
                                if (_state.filteredProducts.isEmpty)
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(40),
                                    decoration: BoxDecoration(
                                      color: AppTheme.cardBg,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: AppTheme.cardBorder,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.search_off,
                                          size: 48,
                                          color: AppTheme.textMuted,
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          "No produce found matching '${_state.searchQuery}'",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.textPrimary,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        const Text(
                                          "Try a different keyword or reset filters.",
                                          style: TextStyle(
                                            color: AppTheme.textMuted,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(height: 14),
                                        ElevatedButton(
                                          onPressed: () {
                                            _state.setSearchQuery("");
                                            _state.setSelectedCategory("All");
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppTheme.gold,
                                            foregroundColor: Colors.black,
                                          ),
                                          child: const Text("Clear Filters"),
                                        ),
                                      ],
                                    ),
                                  )
                                else
                                  _buildProductGrid(
                                    products: _state.filteredProducts,
                                    screenWidth: screenWidth,
                                  ),
                              ],
                            ),
                          ),

                          // Promotional Banner
                          PromoBanner(state: _state),

                          // Today's Specials Section
                          Container(
                            key: _specialsKey,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.amber.withValues(
                                          alpha: 0.15,
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Text(
                                        "Specials",
                                        style: TextStyle(
                                          fontSize: 10.5,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Today's Specials",
                                      style: GoogleFonts.cormorantGaramond(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                _buildProductGrid(
                                  products: _state.specialsProducts,
                                  screenWidth: screenWidth,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Popular Harvests Section
                          Container(
                            key: _popularKey,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppTheme.saleRedMuted,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Text(
                                        "Popular",
                                        style: TextStyle(
                                          fontSize: 10.5,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.saleRed,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Most Ordered Produce",
                                      style: GoogleFonts.cormorantGaramond(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                _buildProductGrid(
                                  products: _state.popularProducts,
                                  screenWidth: screenWidth,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Customer Reviews Section
                          Container(
                            key: _reviewsKey,
                            child: ReviewsSection(state: _state),
                          ),

                          const SizedBox(height: 36),

                          // Comprehensive Store Footer
                          Container(
                            key: _footerKey,
                            child: StoreFooter(
                              onScrollToProduce: () =>
                                  _scrollToKey(_produceKey),
                              onScrollToSpecials: () =>
                                  _scrollToKey(_specialsKey),
                              onScrollToPopular: () =>
                                  _scrollToKey(_popularKey),
                              onScrollToReviews: () =>
                                  _scrollToKey(_reviewsKey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductGrid({
    required List<Product> products,
    required double screenWidth,
  }) {
    int crossAxisCount = 2;
    double childAspectRatio = 0.68;

    if (screenWidth >= 1150) {
      crossAxisCount = 4;
      childAspectRatio = 0.70;
    } else if (screenWidth >= 850) {
      crossAxisCount = 3;
      childAspectRatio = 0.69;
    } else if (screenWidth >= 600) {
      crossAxisCount = 2;
      childAspectRatio = 0.72;
    } else {
      crossAxisCount = 2;
      childAspectRatio = 0.58;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          state: _state,
          onTap: () => _showProductDetail(product),
        );
      },
    );
  }
}
