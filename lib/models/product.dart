class Product {
  final String id;
  final String name;
  final String category;
  final String brand;
  final double price;
  final double originalPrice;
  final String imageUrl;
  final String description;
  final double rating;
  final int reviewCount;
  final String? badge; // e.g., 'Fresh Harvest', 'Best Seller', '-15%'
  final String unit; // e.g. 'Per Bag', '5kg Pack', 'Single Tuber', 'Live Bird'
  final bool isSpecial;
  final bool isPopular;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.brand,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    required this.description,
    this.rating = 4.9,
    this.reviewCount = 18,
    this.badge,
    required this.unit,
    this.isSpecial = false,
    this.isPopular = false,
  });

  int get discountPercent {
    if (originalPrice <= price) return 0;
    return (((originalPrice - price) / originalPrice) * 100).round();
  }
}
