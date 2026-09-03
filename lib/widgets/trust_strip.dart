import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TrustStrip extends StatelessWidget {
  const TrustStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
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
                Expanded(
                  child: _TrustItem(
                    icon: "🥬",
                    label: "Fresh Daily",
                    desc: "Harvested fresh from soil",
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _TrustItem(
                    icon: "🛵",
                    label: "Fast Delivery",
                    desc: "Doorstep delivery across Ibadan",
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _TrustItem(
                    icon: "📦",
                    label: "Bulk & Retail",
                    desc: "Packs, cartons & wholesale sacks",
                  ),
                ),
              ],
            );
          } else {
            return const Column(
              children: [
                _TrustItem(
                  icon: "🥬",
                  label: "Fresh Daily",
                  desc: "Harvested fresh from soil",
                ),
                SizedBox(height: 12),
                _TrustItem(
                  icon: "🛵",
                  label: "Fast Delivery",
                  desc: "Doorstep delivery across Ibadan & beyond",
                ),
                SizedBox(height: 12),
                _TrustItem(
                  icon: "📦",
                  label: "Bulk & Retail",
                  desc: "Packs, cartons & wholesale sacks",
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
      children: [
        Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppTheme.cardBgElevated,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.cardBorder),
          ),
          child: Text(icon, style: const TextStyle(fontSize: 18)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
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
              const SizedBox(height: 2),
              Text(
                desc,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppTheme.textMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
