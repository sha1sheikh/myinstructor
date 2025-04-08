class Instructor {
  final String id;
  final String name;
  final String location;
  final double price;
  final String duration;
  final String experience;
  final double rating;
  final int reviewCount;
  final String image;
  bool isFavorite;

  Instructor({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.duration,
    required this.experience,
    required this.rating,
    required this.reviewCount,
    required this.image,
    this.isFavorite = false,
  });
}