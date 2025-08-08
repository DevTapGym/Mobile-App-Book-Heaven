enum OrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  delivered,
  cancelled,
}

class OrderItem {
  final String bookId;
  final String bookTitle;
  final String bookImage;
  final String author;
  final double price;
  final int quantity;

  OrderItem({
    required this.bookId,
    required this.bookTitle,
    required this.bookImage,
    required this.author,
    required this.price,
    required this.quantity,
  });

  double get totalPrice => price * quantity;

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      bookId: json['bookId'] ?? '',
      bookTitle: json['bookTitle'] ?? '',
      bookImage: json['bookImage'] ?? '',
      author: json['author'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'bookTitle': bookTitle,
      'bookImage': bookImage,
      'author': author,
      'price': price,
      'quantity': quantity,
    };
  }
}

class Order {
  final String id;
  final List<OrderItem> items;
  final double totalAmount;
  final double shippingFee;
  final double discount;
  final OrderStatus status;
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final String shippingAddress;
  final String customerName;
  final String customerPhone;
  final String? trackingNumber;

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    this.shippingFee = 0.0,
    this.discount = 0.0,
    required this.status,
    required this.orderDate,
    this.deliveryDate,
    required this.shippingAddress,
    required this.customerName,
    required this.customerPhone,
    this.trackingNumber,
  });

  double get finalAmount => totalAmount + shippingFee - discount;

  String get statusText {
    switch (status) {
      case OrderStatus.pending:
        return 'Chờ xác nhận';
      case OrderStatus.confirmed:
        return 'Đã xác nhận';
      case OrderStatus.processing:
        return 'Đang xử lý';
      case OrderStatus.shipped:
        return 'Đang giao hàng';
      case OrderStatus.delivered:
        return 'Đã giao hàng';
      case OrderStatus.cancelled:
        return 'Đã hủy';
    }
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      items:
          (json['items'] as List<dynamic>?)
              ?.map((item) => OrderItem.fromJson(item))
              .toList() ??
          [],
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      shippingFee: (json['shippingFee'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
      status: OrderStatus.values[json['status'] ?? 0],
      orderDate: DateTime.parse(
        json['orderDate'] ?? DateTime.now().toIso8601String(),
      ),
      deliveryDate:
          json['deliveryDate'] != null
              ? DateTime.parse(json['deliveryDate'])
              : null,
      shippingAddress: json['shippingAddress'] ?? '',
      customerName: json['customerName'] ?? '',
      customerPhone: json['customerPhone'] ?? '',
      trackingNumber: json['trackingNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'shippingFee': shippingFee,
      'discount': discount,
      'status': status.index,
      'orderDate': orderDate.toIso8601String(),
      'deliveryDate': deliveryDate?.toIso8601String(),
      'shippingAddress': shippingAddress,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'trackingNumber': trackingNumber,
    };
  }
}
