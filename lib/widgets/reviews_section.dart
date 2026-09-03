import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../state/store_state.dart';
import '../models/review.dart';

class ReviewsSection extends StatelessWidget {
  final StoreState state;

  const ReviewsSection({super.key, required this.state});

  void _showAddReviewDialog(BuildContext context) {
    final authorController = TextEditingController();
    final commentController = TextEditingController();
    double selectedRating = 5.0;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: AppTheme.cardBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppTheme.cardBorder),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Write a Review",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: AppTheme.textMuted, size: 20),
                            onPressed: () => Navigator.of(dialogContext).pop(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Rating stars selector
                      Row(
                        children: [
                          const Text("Rating: ", style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
                          ...List.generate(5, (index) {
                            final starVal = index + 1.0;
                            return IconButton(
                              icon: Icon(
                                starVal <= selectedRating ? Icons.star : Icons.star_border,
                                color: Colors.amber,
                                size: 22,
                              ),
                              onPressed: () {
                                setDialogState(() => selectedRating = starVal);
                              },
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Name
                      TextField(
                        controller: authorController,
                        style: const TextStyle(fontSize: 13, color: AppTheme.textPrimary),
                        decoration: InputDecoration(
                          hintText: "Your Name (e.g. Tunde A.)",
                          hintStyle: const TextStyle(fontSize: 12.5, color: AppTheme.textMuted),
                          filled: true,
                          fillColor: AppTheme.cardBgElevated,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: AppTheme.cardBorder),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Comment
                      TextField(
                        controller: commentController,
                        maxLines: 3,
                        style: const TextStyle(fontSize: 13, color: AppTheme.textPrimary),
                        decoration: InputDecoration(
                          hintText: "Share your experience with our farm produce…",
                          hintStyle: const TextStyle(fontSize: 12.5, color: AppTheme.textMuted),
                          filled: true,
                          fillColor: AppTheme.cardBgElevated,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: AppTheme.cardBorder),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          onPressed: () {
                            if (authorController.text.trim().isNotEmpty &&
                                commentController.text.trim().isNotEmpty) {
                              state.addReview(
                                authorController.text.trim(),
                                selectedRating,
                                commentController.text.trim(),
                              );
                              Navigator.of(dialogContext).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: AppTheme.cardBgElevated,
                                  content: Text(
                                    "Thank you! Your review has been posted.",
                                    style: TextStyle(color: AppTheme.textPrimary),
                                  ),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.gold,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          child: const Text("Post Review"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Head
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Text(
                    "Customer Reviews",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text("★ 4.9", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
              TextButton.icon(
                onPressed: () => _showAddReviewDialog(context),
                icon: const Icon(Icons.rate_review_outlined, size: 16, color: AppTheme.gold),
                label: const Text(
                  "Write a review →",
                  style: TextStyle(color: AppTheme.gold, fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Grid / List of reviews
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 700;
              final crossAxisCount = isWide ? 2 : 1;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisExtent: 135,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: state.reviews.length,
                itemBuilder: (context, index) {
                  final rev = state.reviews[index];
                  return _ReviewCard(review: rev);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final CustomerReview review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: AppTheme.cardBgElevated,
                      child: Text(
                        review.author.isNotEmpty ? review.author[0] : "C",
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.gold),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        review.author,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ),
                    if (review.isVerifiedBuyer) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.verified, size: 13, color: AppTheme.verifiedBlue),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Row(
                children: [
                  Text(
                    "★" * review.rating.round(),
                    style: const TextStyle(color: Colors.amber, fontSize: 11),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    review.date,
                    style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              review.comment,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
