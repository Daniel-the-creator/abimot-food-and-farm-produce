class CustomerReview {
  final String id;
  final String author;
  final double rating;
  final String comment;
  final String date;
  final bool isVerifiedBuyer;

  const CustomerReview({
    required this.id,
    required this.author,
    required this.rating,
    required this.comment,
    required this.date,
    this.isVerifiedBuyer = true,
  });
}
