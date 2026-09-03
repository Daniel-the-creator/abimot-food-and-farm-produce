import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../data/farm_data.dart';

class StoreFooter extends StatelessWidget {
  final VoidCallback onScrollToProduce;
  final VoidCallback onScrollToSpecials;
  final VoidCallback onScrollToPopular;
  final VoidCallback onScrollToReviews;

  const StoreFooter({
    super.key,
    required this.onScrollToProduce,
    required this.onScrollToSpecials,
    required this.onScrollToPopular,
    required this.onScrollToReviews,
  });

  Future<void> _launchWhatsApp() async {
    final url = Uri.parse("https://wa.me/${FarmData.whatsappNumber}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF090A0E),
        border: Border(top: BorderSide(color: AppTheme.cardBorder, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      child: Column(
        children: [
          // Newsletter band
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(bottom: 32),
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.cardBorder),
            ),
            child: isDesktop
                ? Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Stay in the Loop with Fresh Harvests",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Receive weekly farm restock notices, seasonal price cuts & wholesale updates.",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      _buildNewsletterForm(context),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Stay in the Loop with Fresh Harvests",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Receive weekly farm restock notices, seasonal price cuts & wholesale updates.",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textMuted,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _buildNewsletterForm(context),
                    ],
                  ),
          ),

          // Main Links Grid
          Wrap(
            spacing: 36,
            runSpacing: 24,
            alignment: WrapAlignment.spaceBetween,
            children: [
              // Col 1: Brand
              SizedBox(
                width: isDesktop ? 260 : double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppTheme.cardBorder),
                            image: const DecorationImage(
                              image: NetworkImage(
                                "https://images.unsplash.com/photo-1597362925123-77861d3fbac7?q=80&w=200&auto=format&fit=crop",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Abimot",
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 20,
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
                    const SizedBox(height: 10),
                    const Text(
                      FarmData.storeTagline,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textMuted,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Row(
                      children: [
                        Text(
                          "Powered by ",
                          style: TextStyle(
                            fontSize: 11,
                            color: AppTheme.textMuted,
                          ),
                        ),
                        Text(
                          "Abimot",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.gold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Col 2: Store Navigation
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Store Menu",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _footerLink("Produce Catalog", onScrollToProduce),
                  _footerLink("Today's Specials", onScrollToSpecials),
                  _footerLink("Popular Harvests", onScrollToPopular),
                  _footerLink("Customer Reviews", onScrollToReviews),
                ],
              ),

              // Col 3: Categories
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Top Categories",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _footerLink("Tubers & Staples", onScrollToProduce),
                  _footerLink("Fresh Vegetables", onScrollToProduce),
                  _footerLink("Poultry & Livestock", onScrollToProduce),
                  _footerLink("Pure Palm Oil & Grains", onScrollToProduce),
                  _footerLink("Farm Combos", onScrollToProduce),
                ],
              ),

              // Col 4: Support & WhatsApp
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Customer Support",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _footerLink("💬 Chat on WhatsApp", _launchWhatsApp),
                  _footerLink("Delivery & Bulk Inquiries", () {}),
                  _footerLink("Return & Quality Guarantee", () {}),
                ],
              ),
            ],
          ),

          const SizedBox(height: 32),
          const Divider(color: AppTheme.cardBorder, height: 1),
          const SizedBox(height: 20),

          // Bottom Bar
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "© 2026 Abimot Food & Farm Produce. All rights reserved.",
                    style: TextStyle(fontSize: 11.5, color: AppTheme.textMuted),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.verified, size: 12, color: AppTheme.verifiedBlue),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppTheme.cardBgElevated,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppTheme.cardBorder),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lock_outline, size: 12, color: AppTheme.emerald),
                    SizedBox(width: 4),
                    Text(
                      "Bank Secured",
                      style: TextStyle(
                        fontSize: 10.5,
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildNewsletterForm(BuildContext context) {
    final controller = TextEditingController();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 220,
          height: 38,
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: 12.5, color: AppTheme.textPrimary),
            decoration: InputDecoration(
              hintText: "Enter your email address",
              hintStyle: const TextStyle(
                fontSize: 12,
                color: AppTheme.textMuted,
              ),
              filled: true,
              fillColor: AppTheme.cardBgElevated,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppTheme.cardBorder),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          height: 38,
          child: ElevatedButton(
            onPressed: () {
              if (controller.text.contains("@")) {
                controller.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppTheme.cardBgElevated,
                    content: Text(
                      "Thank you for subscribing to farm harvest updates!",
                      style: TextStyle(color: AppTheme.textPrimary),
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.gold,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text("Subscribe"),
          ),
        ),
      ],
    );
  }

  Widget _footerLink(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        child: Text(
          title,
          style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
        ),
      ),
    );
  }
}
