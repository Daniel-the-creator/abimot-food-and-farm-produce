import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../data/farm_data.dart';
import '../state/store_state.dart';

class HeroCarousel extends StatefulWidget {
  final StoreState state;
  final VoidCallback onExploreClick;

  const HeroCarousel({
    super.key,
    required this.state,
    required this.onExploreClick,
  });

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  int _currentIndex = 0;
  Timer? _sliderTimer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _sliderTimer?.cancel();
    _sliderTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % FarmData.heroSlides.length;
        });
      }
    });
  }

  void _nextSlide() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % FarmData.heroSlides.length;
    });
    _startAutoSlide();
  }

  void _prevSlide() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + FarmData.heroSlides.length) % FarmData.heroSlides.length;
    });
    _startAutoSlide();
  }

  void _goToSlide(int index) {
    setState(() {
      _currentIndex = index;
    });
    _startAutoSlide();
  }

  @override
  void dispose() {
    _sliderTimer?.cancel();
    super.dispose();
  }

  Future<void> _launchWhatsApp() async {
    final url = Uri.parse(
      "https://wa.me/${FarmData.whatsappNumber}?text=${Uri.encodeComponent("Hello Abimot Food & Farm Produce, I would like to inquire about today's fresh harvests!")}",
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentSlide = FarmData.heroSlides[_currentIndex];
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 900;
    final heroHeight = isDesktop ? 480.0 : 420.0;

    return Container(
      width: double.infinity,
      height: heroHeight,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.cardBorder, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image with Animated Fade
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 700),
            child: Image.network(
              currentSlide.imageUrl,
              key: ValueKey(currentSlide.imageUrl),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(color: AppTheme.cardBgElevated);
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppTheme.cardBgElevated,
                  child: const Center(
                    child: Icon(Icons.grass, size: 64, color: AppTheme.emerald),
                  ),
                );
              },
            ),
          ),

          // Cinematic Dark Gradient Scrim
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withValues(alpha: 0.94),
                  Colors.black.withValues(alpha: 0.82),
                  Colors.black.withValues(alpha: 0.45),
                ],
              ),
            ),
          ),

          // Bottom Glow
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.75),
                ],
              ),
            ),
          ),

          // Hero Content Panel
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 44.0 : 20.0,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Eyebrows & Badges
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      currentSlide.categoryTag.toUpperCase(),
                      style: const TextStyle(
                        color: AppTheme.gold,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.8,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: 0.15),
                        border: Border.all(color: Colors.amber.withValues(alpha: 0.4)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        currentSlide.badge,
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppTheme.emerald.withValues(alpha: 0.15),
                        border: Border.all(color: AppTheme.emerald.withValues(alpha: 0.4)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "★ 100% Organic",
                        style: TextStyle(
                          color: AppTheme.emerald,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Main Title with Verified Badge
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        FarmData.storeName,
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: isDesktop ? 38 : 26,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                          letterSpacing: -0.5,
                          height: 1.1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: AppTheme.verifiedBlue,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        size: isDesktop ? 16 : 13,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Tagline / Subtitle
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 580),
                  child: Text(
                    currentSlide.subtitle,
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: isDesktop ? 14 : 12.5,
                      height: 1.45,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Today's Special Pill
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBg.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppTheme.gold.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.auto_awesome, size: 14, color: AppTheme.gold),
                      const SizedBox(width: 6),
                      Text(
                        "Today's Special · ${currentSlide.specialDish} ",
                        style: const TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "₦${currentSlide.specialPrice.toStringAsFixed(0)}",
                        style: const TextStyle(
                          color: AppTheme.gold,
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // Footer row: Like button, metadata, CTAs
                Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // Like button
                    InkWell(
                      onTap: widget.state.toggleStoreLike,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.cardBgElevated,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppTheme.cardBorder),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.state.isStoreLiked ? "❤️" : "🤍",
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              widget.state.isStoreLiked ? "Liked" : "Like Store",
                              style: const TextStyle(
                                fontSize: 11.5,
                                color: AppTheme.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "${widget.state.storeLikes}",
                                style: const TextStyle(fontSize: 10.5, color: AppTheme.textSecondary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Primary CTA (Explore produce)
                    ElevatedButton.icon(
                      onPressed: widget.onExploreClick,
                      icon: const Icon(Icons.restaurant_menu, size: 16),
                      label: const Text("Explore Produce"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.gold,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        textStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
                      ),
                    ),

                    // Secondary CTA (WhatsApp Order)
                    OutlinedButton.icon(
                      onPressed: _launchWhatsApp,
                      icon: const Text("💬", style: TextStyle(fontSize: 14)),
                      label: const Text("Order on WhatsApp"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.textPrimary,
                        side: const BorderSide(color: AppTheme.cardBorder),
                        backgroundColor: AppTheme.cardBg.withValues(alpha: 0.6),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        textStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Slider Chevron & Dots Controls (Bottom Right)
          Positioned(
            right: 20,
            bottom: 20,
            child: Row(
              children: [
                IconButton(
                  onPressed: _prevSlide,
                  icon: const Icon(Icons.chevron_left, color: AppTheme.textPrimary),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black.withValues(alpha: 0.5),
                    shape: const CircleBorder(),
                  ),
                ),
                const SizedBox(width: 6),
                Row(
                  children: List.generate(FarmData.heroSlides.length, (index) {
                    final isActive = index == _currentIndex;
                    return GestureDetector(
                      onTap: () => _goToSlide(index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: isActive ? 18 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: isActive ? AppTheme.gold : Colors.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(width: 6),
                IconButton(
                  onPressed: _nextSlide,
                  icon: const Icon(Icons.chevron_right, color: AppTheme.textPrimary),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black.withValues(alpha: 0.5),
                    shape: const CircleBorder(),
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
