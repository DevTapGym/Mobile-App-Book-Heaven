class Book {
  final String id;
  final String title;
  final String author;
  final double price;
  final double? originalPrice;
  final String description;
  final String category;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final List<String> tags;
  final bool isAvailable;
  final int stockQuantity;
  final DateTime publishDate;
  final String isbn;
  final int pageCount;
  final String language;
  final String publisher;
  final bool isFavorite;
  final int discount; // Percentage discount

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    this.originalPrice,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.tags,
    this.isAvailable = true,
    required this.stockQuantity,
    required this.publishDate,
    required this.isbn,
    required this.pageCount,
    this.language = 'English',
    required this.publisher,
    this.isFavorite = false,
    this.discount = 0,
  });

  double get discountAmount =>
      originalPrice != null ? originalPrice! - price : 0;
  double get discountPercentage =>
      originalPrice != null && originalPrice! > 0
          ? ((originalPrice! - price) / originalPrice! * 100).round().toDouble()
          : 0;

  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      originalPrice: json['originalPrice']?.toDouble(),
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      tags: List<String>.from(json['tags'] ?? []),
      isAvailable: json['isAvailable'] ?? true,
      stockQuantity: json['stockQuantity'] ?? 0,
      publishDate: DateTime.parse(
        json['publishDate'] ?? DateTime.now().toIso8601String(),
      ),
      isbn: json['isbn'] ?? '',
      pageCount: json['pageCount'] ?? 0,
      language: json['language'] ?? 'English',
      publisher: json['publisher'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
      discount: json['discount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'price': price,
      'originalPrice': originalPrice,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
      'rating': rating,
      'reviewCount': reviewCount,
      'tags': tags,
      'isAvailable': isAvailable,
      'stockQuantity': stockQuantity,
      'publishDate': publishDate.toIso8601String(),
      'isbn': isbn,
      'pageCount': pageCount,
      'language': language,
      'publisher': publisher,
      'isFavorite': isFavorite,
      'discount': discount,
    };
  }

  Book copyWith({
    String? id,
    String? title,
    String? author,
    double? price,
    double? originalPrice,
    String? description,
    String? category,
    String? imageUrl,
    double? rating,
    int? reviewCount,
    List<String>? tags,
    bool? isAvailable,
    int? stockQuantity,
    DateTime? publishDate,
    String? isbn,
    int? pageCount,
    String? language,
    String? publisher,
    bool? isFavorite,
    int? discount,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      description: description ?? this.description,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      tags: tags ?? this.tags,
      isAvailable: isAvailable ?? this.isAvailable,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      publishDate: publishDate ?? this.publishDate,
      isbn: isbn ?? this.isbn,
      pageCount: pageCount ?? this.pageCount,
      language: language ?? this.language,
      publisher: publisher ?? this.publisher,
      isFavorite: isFavorite ?? this.isFavorite,
      discount: discount ?? this.discount,
    );
  }
}

// Enum for search/filter types
enum SearchType {
  search,
  category,
  featured,
  popular,
  recommended,
  newReleases,
}

// Class for search parameters
class SearchParams {
  final String query;
  final SearchType type;
  final String? category;
  final double? minPrice;
  final double? maxPrice;
  final double? minRating;
  final String? sortBy; // price_low, price_high, rating, title, newest
  final List<String> tags;

  SearchParams({
    this.query = '',
    required this.type,
    this.category,
    this.minPrice,
    this.maxPrice,
    this.minRating,
    this.sortBy,
    this.tags = const [],
  });

  SearchParams copyWith({
    String? query,
    SearchType? type,
    String? category,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    String? sortBy,
    List<String>? tags,
  }) {
    return SearchParams(
      query: query ?? this.query,
      type: type ?? this.type,
      category: category ?? this.category,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minRating: minRating ?? this.minRating,
      sortBy: sortBy ?? this.sortBy,
      tags: tags ?? this.tags,
    );
  }
}
