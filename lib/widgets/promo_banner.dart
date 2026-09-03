import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/farm_data.dart';
import '../state/store_state.dart';

class PromoBanner extends StatelessWidget {
  final StoreState state;

  const PromoBanner({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    // Combo item
    final combo = FarmData.products.firstWhere(
      (p) => p.category == "Farm Combos",
      orElse: () => FarmData.products.last,
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      height: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background photo
          Image.network(
            "https://images.unsplash.com/photo-1547592180-85f173990554?q=80&w=1400&auto=format&fit=crop",
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) =>
                progress == null ? child : Container(color: AppTheme.cardBgElevated),
            errorBuilder: (context, error, stackTrace) => Container(color: AppTheme.cardBgElevated),
          ),

          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withValues(alpha: 0.92),
                  Colors.black.withValues(alpha: 0.75),
                  Colors.black.withValues(alpha: 0.35),
                ],
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppTheme.gold.withValues(alpha: 0.2),
                    border: Border.all(color: AppTheme.gold.withValues(alpha: 0.5)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "LIMITED TIME COMBO DEAL",
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.gold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  combo.name,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: const Text(
                    "1 Paint Egusi + 2L Pure Palm Oil + 1 Smoked Catfish Carton + 2 Ugu Bunches + 1 Bag Crayfish. Ready for authentic family delicacies.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: AppTheme.textSecondary,
                      height: 1.3,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Text(
                      "₦${combo.price.toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.gold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "₦${combo.originalPrice.toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.textMuted,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        state.addToCart(combo);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: AppTheme.cardBgElevated,
                            content: Text(
                              "Soup Starter Combo added to cart!",
                              style: TextStyle(color: AppTheme.textPrimary),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.gold,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      child: const Text("Order Combo Now →"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
