import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MarqueeBanner extends StatefulWidget {
  const MarqueeBanner({super.key});

  @override
  State<MarqueeBanner> createState() => _MarqueeBannerState();
}

class _MarqueeBannerState extends State<MarqueeBanner> {
  late final ScrollController _scrollController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startScrolling());
  }

  void _startScrolling() {
    _timer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      if (!_scrollController.hasClients) return;
      final maxExtent = _scrollController.position.maxScrollExtent;
      final currentOffset = _scrollController.offset;
      if (currentOffset >= maxExtent) {
        _scrollController.jumpTo(0);
      } else {
        _scrollController.jumpTo(currentOffset + 1.2);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const announcement =
        "Abimot: Fresh Farm Produce Direct to Your Doorstep  ·  100% Organic & Farm Fresh  ·   Delivery to every part of ibadan and beyond ·  Secure Checkout  ·  Bulk Supplies & Catering Orders Available  ·  ";

    return Container(
      height: 34,
      decoration: const BoxDecoration(
        color: Color(0xFF10121A),
        border: Border(
          bottom: BorderSide(color: AppTheme.cardBorder, width: 0.8),
        ),
      ),
      child: IgnorePointer(
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 15,
          itemBuilder: (context, index) {
            return Center(
              child: Row(
                children: [
                  Text(
                    announcement,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 11.5,
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
