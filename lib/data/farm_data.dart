import '../models/product.dart';
import '../models/review.dart';

class HeroSlideData {
  final String title;
  final String subtitle;
  final String specialDish;
  final double specialPrice;
  final String imageUrl;
  final String categoryTag;
  final String badge;

  const HeroSlideData({
    required this.title,
    required this.subtitle,
    required this.specialDish,
    required this.specialPrice,
    required this.imageUrl,
    required this.categoryTag,
    required this.badge,
  });
}

class FarmData {
  static const String storeName = "Abimot Food and Farm Produce";
  static const String storeTagline =
      "Your Cravings for Fresh Organic Harvest, Farm Direct, All in One Place.";
  static const String storeDomain = "abimot.com";
  static const String whatsappNumber = "2348036671429";

  static const List<HeroSlideData> heroSlides = [
    HeroSlideData(
      title: "Abimot Food and Farm Produce",
      subtitle:
          "Fresh farm-grown plantain, perfect for frying, boiling, roasting, and delicious homemade meals.",
      specialDish: "12 bunches of plantain",
      specialPrice: 16500,
      imageUrl:
          "https://plus.unsplash.com/premium_photo-1663954864079-7452e284aeae?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8YnVuY2glMjBvZiUyMHBsYW50YWlufGVufDB8fDB8fHww",
      categoryTag: "Fresh Farm Produce",
      badge: "▲ Top Seller",
    ),
    HeroSlideData(
      title: "100% Organic & Farm Fresh",
      subtitle:
          "Harvested at dawn and delivered crisp to your home, kitchen, and catering events.",
      specialDish: "Farm Dressed Jumbo Broiler (2.8kg)",
      specialPrice: 9500,
      imageUrl:
          "https://images.unsplash.com/photo-1548550023-2bdb3c5beed7?q=80&w=1600&auto=format&fit=crop",
      categoryTag: "Poultry & Meat",
      badge: "★ Trusted Farm",
    ),
    HeroSlideData(
      title: "Pure Oils & Native Seasonings",
      subtitle:
          "Zero additives, unadulterated cold-pressed palm oil and hand-sorted soup staples.",
      specialDish: "Pure Nsukka Palm Oil (5 Litre Keg)",
      specialPrice: 11000,
      imageUrl:
          "https://images.unsplash.com/photo-1773601583921-ed51a49def17?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cmVkJTIwb2lsJTIwaW4lMjBrZWd8ZW58MHx8MHx8fDA%3D",
      categoryTag: "Oils & Spices",
      badge: "✓ Verified Quality",
    ),
    HeroSlideData(
      title: "Grains, Flours & Bulk Staples",
      subtitle:
          "Fresh yam tubers, naturally grown and carefully selected for delicious, hearty meals.",
      specialDish: "Yam",
      specialPrice: 24000,
      imageUrl:
          "https://media.istockphoto.com/id/1126342060/photo/yam-isolated-on-white-background.webp?a=1&b=1&s=612x612&w=0&k=20&c=xYiG6L2xgufMAPB9sJZEcNGU629wPmP0F_BgMPSdP8c=",
      categoryTag: "Fresh Farm Produce",
      badge: "🔥 Best Value",
    ),
  ];

  static const List<String> categories = [
    "All",
    "Fresh Farm Produce",
    "Fresh Vegetables",
    "Poultry & Meat",
    "Grains & Flours",
    "Oils & Condiments",
    "Farm Combos",
  ];

  static const List<Product> products = [
    Product(
      id: "prod-plantain-01",
      name: "dozen of plantain",
      category: "Fresh Farm Produce",
      brand: "ikire Farms",
      price: 16500,
      originalPrice: 19500,
      imageUrl:
          "https://plus.unsplash.com/premium_photo-1663954864079-7452e284aeae?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8YnVuY2glMjBvZiUyMHBsYW50YWlufGVufDB8fDB8fHww",
      description:
          "Direct harvest from ikire. Sweet plantain. Perfect for frying, boiling, or delicious plaintain pottage.",
      unit: "1 dozen of plantain",
      badge: "-15%",
      rating: 4.9,
      reviewCount: 34,
      isSpecial: true,
      isPopular: true,
    ),
    Product(
      id: "prod-broiler-02",
      name: "Farm Dressed Jumbo Broiler Chicken (2.8kg)",
      category: "Poultry & Meat",
      brand: "Abimot Poultry",
      price: 9500,
      originalPrice: 11200,
      imageUrl:
          "https://images.unsplash.com/photo-1587593810167-a84920ea0781?q=80&w=800&auto=format&fit=crop",
      description:
          "Hygienically slaughtered, properly plucked, eviscerated, and blast-chilled. Tender, juicy, grain-fed broiler chicken.",
      unit: "Whole Bird (2.8kg)",
      badge: "-15%",
      rating: 5.0,
      reviewCount: 42,
      isSpecial: true,
      isPopular: true,
    ),
    Product(
      id: "prod-palmoil-03",
      name: "Pure Palm Oil (5L Keg)",
      category: "Oils & Condiments",
      brand: "Abimot Harvest",
      price: 11000,
      originalPrice: 13000,
      imageUrl:
          "https://images.unsplash.com/photo-1471193945509-9ad0617afabf?q=80&w=800&auto=format&fit=crop",
      description:
          "100% unadulterated red palm oil with rich aroma and thick texture. Free from artificial colors, chemicals, or water dilution.",
      unit: "5 Litre Keg",
      badge: "-15%",
      rating: 4.9,
      reviewCount: 56,
      isSpecial: false,
      isPopular: true,
    ),
    Product(
      id: "prod-yam-04",
      name: "Yam (25kg)",
      category: "Fresh Farm Produce",
      brand: "Ogun Valley",
      price: 13500,
      originalPrice: 15500,
      imageUrl:
          "https://media.istockphoto.com/id/1126342060/photo/yam-isolated-on-white-background.webp?a=1&b=1&s=612x612&w=0&k=20&c=xYiG6L2xgufMAPB9sJZEcNGU629wPmP0F_BgMPSdP8c=",
      description:
          "Fresh, high-quality yam tubers, naturally grown and carefully selected for their excellent taste, smooth texture, and versatility. Perfect for boiling, frying, pounding, roasting, or preparing your favorite traditional meals.",
      unit: "25kg",
      badge: "-13%",
      rating: 4.8,
      reviewCount: 29,
      isSpecial: true,
      isPopular: true,
    ),
    Product(
      id: "prod-garri-05",
      name: "Crisp Ijebu White Garri (1 Paint Bucket)",
      category: "Grains & Flours",
      brand: "Ijebu Origin",
      price: 4500,
      originalPrice: 5300,
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMhkDYE6E5L4J0rTjMJG0dZLJjK_z3PKkjJQuFGyhr2g&s=10",
      description:
          "Fine, sour, extra-crisp Ijebu garri. Swells remarkably and remains crunchy when soaked with groundnuts and milk.",
      unit: "4 Litre Bucket",
      badge: "-15%",
      rating: 5.0,
      reviewCount: 68,
      isSpecial: false,
      isPopular: true,
    ),
    Product(
      id: "prod-ugu-06",
      name: "Fresh Crisp Ugu (Pumpkin) Leaves Bundle",
      category: "Fresh Vegetables",
      brand: "Abimot Greens",
      price: 2500,
      originalPrice: 3000,
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhss2vbXDcpqp1NzUxrL5C7Ek9dLcUamkiDwUc8692XQ&s=10",
      description:
          "Freshly cut fluted pumpkin leaves (Ugu), lush green and rich in iron. Great for Egusi soup, Edikang Ikong, and healthy smoothies.",
      unit: "Big Tied Bunch",
      badge: "Harvested Today",
      rating: 4.9,
      reviewCount: 19,
      isSpecial: true,
      isPopular: false,
    ),
    Product(
      id: "prod-catfish-07",
      name: "Oven-Dried Smoked Catfish (Carton of 10)",
      category: "Poultry & Meat",
      brand: "Farm Delta",
      price: 14000,
      originalPrice: 16500,
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThWsKovxVsxVR6zXe5I35jCjHKv62eYZ-evS-gJ2yqdw&s=10",
      description:
          "Sand-free, thoroughly de-gutted and wood-smoked catfish. Fragrant, golden brown, and adds deep umami flavor to soups.",
      unit: "10 Medium Fish",
      badge: "-15%",
      rating: 4.9,
      reviewCount: 27,
      isSpecial: false,
      isPopular: true,
    ),
    Product(
      id: "prod-plantain-08",
      name: "Fresh Big Bunch of Unripe / Semi-Ripe Plantains",
      category: "Tubers & Staples",
      brand: "Edo Groves",
      price: 8500,
      originalPrice: 10000,
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkC7xkLLbeUVLkB17Ixi1ap0tyX9oDDADuRjusq9Ch3g&s=10",
      description:
          "Heavy whole bunch of farm-fresh plantains. Ideal for dodo, bole, plantain porridge, or healthy unripe plantain flour.",
      unit: "1 Large Bunch",
      badge: "-15%",
      rating: 4.7,
      reviewCount: 22,
      isSpecial: false,
      isPopular: true,
    ),
    Product(
      id: "prod-pepper-09",
      name: "Fresh Scotch Bonnet Pepper & Tomatoes Basket",
      category: "Fresh Vegetables",
      brand: "Jos Plateau",
      price: 7500,
      originalPrice: 9000,
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9YxCGWFF3jKQC1CzLGVcaG7ZCKbIfsC0pNW1hpaDP1A&s=10",
      description:
          "Spicy aromatic Ata Rodo peppers, Sombo chili, and firm plum tomatoes sourced straight from Jos cool farms.",
      unit: "Half Basket",
      badge: "-17%",
      rating: 4.8,
      reviewCount: 31,
      isSpecial: true,
      isPopular: false,
    ),
    Product(
      id: "prod-egusi-10",
      name: "Hand-Peeled Premium Melon Seeds (Egusi - 4L)",
      category: "Oils & Condiments",
      brand: "Benue Valley",
      price: 7000,
      originalPrice: 8200,
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQgHPYUDJOcImCfBriZ-d0AHk7Ahj--OGotSZ3w7WwWQ&s=10",
      description:
          "Machine-cleaned and hand-sorted melon seeds with rich natural oil content. Ready for blending into velvety soup.",
      unit: "4 Litre Bucket",
      badge: "-15%",
      rating: 4.9,
      reviewCount: 45,
      isSpecial: false,
      isPopular: true,
    ),
    Product(
      id: "prod-eggs-11",
      name: "Farm Fresh Large Brown Eggs (Crate of 30)",
      category: "Poultry & Meat",
      brand: "Abimot Layers",
      price: 5200,
      originalPrice: 6000,
      imageUrl:
          "https://images.unsplash.com/photo-1506976785307-8732e854ad03?q=80&w=800&auto=format&fit=crop",
      description:
          "Collected today from healthy, well-fed layers. Sturdy shells, bright yellow yolks, rich in wholesome protein.",
      unit: "Crate (30 Eggs)",
      badge: "Fresh Daily",
      rating: 5.0,
      reviewCount: 53,
      isSpecial: false,
      isPopular: true,
    ),
    Product(
      id: "prod-combo-12",
      name: "Ultimate Nigerian Soup Starter Combo",
      category: "Farm Combos",
      brand: "Abimot Curated",
      price: 26500,
      originalPrice: 32000,
      imageUrl:
          "https://images.unsplash.com/photo-1547592180-85f173990554?q=80&w=800&auto=format&fit=crop",
      description:
          "Complete feast package: 1 Paint Egusi + 2L Pure Palm Oil + 1 Smoked Catfish carton + 2 Bunches Ugu + 1 Bag Crayfish.",
      unit: "Mega Hamper Box",
      badge: "Save ₦5,500",
      rating: 5.0,
      reviewCount: 38,
      isSpecial: true,
      isPopular: true,
    ),
  ];

  static const List<CustomerReview> initialReviews = [
    CustomerReview(
      id: "rev-1",
      author: "Mrs. Adebayo O.",
      rating: 5.0,
      comment:
          "The Benue yams were huge and tasted naturally sweet! Pounded yam came out smooth without any dark patches. Delivered promptly to Ikeja.",
      date: "2 days ago",
    ),
    CustomerReview(
      id: "rev-2",
      author: "Chukwuma E.",
      rating: 5.0,
      comment:
          "Best pure palm oil I have bought in Lagos in a long time. No smell of artificial colorants or chemical additives. Will keep buying regularly.",
      date: "5 days ago",
    ),
    CustomerReview(
      id: "rev-3",
      author: "Fatima S.",
      rating: 4.8,
      comment:
          "The jumbo broiler was truly big and fresh, clean and ready for seasoning. Made cooking Sunday dinner so convenient.",
      date: "1 week ago",
    ),
    CustomerReview(
      id: "rev-4",
      author: "Dr. Babatunde K.",
      rating: 5.0,
      comment:
          "Ordering via WhatsApp with the automatic cart was so smooth. The stone-free ofada rice made our weekend party a hit.",
      date: "2 weeks ago",
    ),
  ];
}
