import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TrustStrip extends StatelessWidget {
  const TrustStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 720;
          
          if (isWide) {
            return const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _TrustItem(icon: "🥬", label: "Fresh Daily", desc: "Harvested fresh from soil"),
                _TrustItem(icon: "🛵", label: "Fast Delivery", desc: "Same-day doorstep delivery"),
                _TrustItem(icon: "📦", label: "Bulk & Retail", desc: "Packs, cartons & sacks"),
                _TrustItem(icon: "💬", label: "Direct Payment", desc: "Order & pay via WhatsApp"),
              ],
            );
          } else {
            return const Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _TrustItem(icon: "🥬", label: "Fresh Daily", desc: "Harvested fresh from soil")),
                    SizedBox(width: 8),
                    Expanded(child: _TrustItem(icon: "🛵", label: "Fast Delivery", desc: "Same-day doorstep delivery")),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _TrustItem(icon: "📦", label: "Bulk & Retail", desc: "Packs, cartons & sacks")),
                    SizedBox(width: 8),
                    Expanded(child: _TrustItem(icon: "🔒", label: "Secure Payment", desc: "Wavy & Transfer protection")),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class _TrustItem extends StatelessWidget {
  final String icon;
  final String label;
  final String desc;

  const _TrustItem({
    required this.icon,
    required this.label,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppTheme.cardBgElevated,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.cardBorder),
          ),
          child: Text(icon, style: const TextStyle(fontSize: 18)),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              desc,
              style: const TextStyle(
                fontSize: 11,
                color: AppTheme.textMuted,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
