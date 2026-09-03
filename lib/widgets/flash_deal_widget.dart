import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../data/farm_data.dart';
import '../state/store_state.dart';

class FlashDealWidget extends StatefulWidget {
  final StoreState state;

  const FlashDealWidget({super.key, required this.state});

  @override
  State<FlashDealWidget> createState() => _FlashDealWidgetState();
}

class _FlashDealWidgetState extends State<FlashDealWidget> {
  late Duration _remaining;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _remaining = const Duration(hours: 4, minutes: 59, seconds: 59);
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_remaining.inSeconds > 0) {
          _remaining = _remaining - const Duration(seconds: 1);
        } else {
          _remaining = const Duration(hours: 5, minutes: 0, seconds: 0);
        }
      });
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hours = _remaining.inHours.toString().padLeft(2, '0');
    final minutes = (_remaining.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (_remaining.inSeconds % 60).toString().padLeft(2, '0');

    // The flash deal product
    final dealProduct = FarmData.products.first;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.gold.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppTheme.gold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Text("⚡", style: TextStyle(fontSize: 12)),
                    SizedBox(width: 4),
                    Text(
                      "Flash Deal",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.gold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                "-15% OFF",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.saleRed,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            dealProduct.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),

          const SizedBox(height: 4),

          Row(
            children: [
              Text(
                "₦${dealProduct.price.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.gold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "₦${dealProduct.originalPrice.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textMuted,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Countdown Timer row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _TimerBox(value: hours, label: "Hrs"),
              const Text(" : ", style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textMuted)),
              _TimerBox(value: minutes, label: "Min"),
              const Text(" : ", style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textMuted)),
              _TimerBox(value: seconds, label: "Sec"),
            ],
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 38,
            child: ElevatedButton(
              onPressed: () {
                widget.state.addToCart(dealProduct);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppTheme.cardBgElevated,
                    content: Text(
                      "Flash deal added to cart! (${dealProduct.name})",
                      style: const TextStyle(color: AppTheme.textPrimary),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.gold,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              child: const Text("Claim Flash Deal →"),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimerBox extends StatelessWidget {
  final String value;
  final String label;

  const _TimerBox({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.cardBgElevated,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.gold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 9, color: AppTheme.textMuted),
          ),
        ],
      ),
    );
  }
}

class StoreHighlightsWidget extends StatelessWidget {
  const StoreHighlightsWidget({super.key});

  Future<void> _launchWhatsApp() async {
    final url = Uri.parse("https://wa.me/${FarmData.whatsappNumber}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Store Highlights & Assurance",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Text("★★★★★", style: TextStyle(color: Colors.amber, fontSize: 14)),
              SizedBox(width: 6),
              Text(
                "4.9 Rating (140+ orders)",
                style: TextStyle(fontSize: 11.5, color: AppTheme.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _highlightItem("✓", "100% Unadulterated authentic produce"),
          _highlightItem("✓", "Safe, inspected payout & store identity"),
          _highlightItem("✓", "1–2 business days dispatch in Ibadan and lagos"),
          _highlightItem("✓", "Direct cold-chain delivery in Ibadan and Lagos"),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _launchWhatsApp,
              icon: const Text("💬", style: TextStyle(fontSize: 14)),
              label: const Text("Chat with Farm Support"),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.textPrimary,
                side: const BorderSide(color: AppTheme.cardBorder),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 10),
                textStyle: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _highlightItem(String check, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(check, style: const TextStyle(color: AppTheme.emerald, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 11.5, color: AppTheme.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}
