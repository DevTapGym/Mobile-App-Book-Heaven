import 'package:flutter/material.dart';
import 'package:heaven_book_app/themes/app_colors.dart';
import 'package:heaven_book_app/models/order_model.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<Order> _orders = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _loadOrders();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadOrders() {
    setState(() {
      _isLoading = true;
    });

    // Simulate loading orders with sample data
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _orders = _getSampleOrders();
        _isLoading = false;
      });
    });
  }

  List<Order> _getSampleOrders() {
    return [
      Order(
        id: 'ORD-001',
        items: [
          OrderItem(
            bookId: '1',
            bookTitle: 'The Great Gatsby',
            bookImage: 'assets/images/Logo.png',
            author: 'F. Scott Fitzgerald',
            price: 15.99,
            quantity: 1,
          ),
          OrderItem(
            bookId: '2',
            bookTitle: 'To Kill a Mockingbird',
            bookImage: 'assets/images/Logo.png',
            author: 'Harper Lee',
            price: 12.99,
            quantity: 2,
          ),
        ],
        totalAmount: 41.97,
        shippingFee: 5.00,
        discount: 3.00,
        status: OrderStatus.delivered,
        orderDate: DateTime.now().subtract(const Duration(days: 7)),
        deliveryDate: DateTime.now().subtract(const Duration(days: 2)),
        shippingAddress: '123 Main Street, City, State 12345',
        customerName: 'Nguyễn Văn A',
        customerPhone: '+84 123 456 789',
        trackingNumber: 'TRK123456789',
      ),
      Order(
        id: 'ORD-002',
        items: [
          OrderItem(
            bookId: '3',
            bookTitle: '1984',
            bookImage: 'assets/images/Logo.png',
            author: 'George Orwell',
            price: 13.99,
            quantity: 1,
          ),
        ],
        totalAmount: 13.99,
        shippingFee: 5.00,
        discount: 0.00,
        status: OrderStatus.shipped,
        orderDate: DateTime.now().subtract(const Duration(days: 3)),
        shippingAddress: '456 Oak Avenue, City, State 54321',
        customerName: 'Trần Thị B',
        customerPhone: '+84 987 654 321',
        trackingNumber: 'TRK987654321',
      ),
      Order(
        id: 'ORD-003',
        items: [
          OrderItem(
            bookId: '4',
            bookTitle: 'Pride and Prejudice',
            bookImage: 'assets/images/Logo.png',
            author: 'Jane Austen',
            price: 11.99,
            quantity: 1,
          ),
        ],
        totalAmount: 11.99,
        shippingFee: 5.00,
        status: OrderStatus.processing,
        orderDate: DateTime.now().subtract(const Duration(days: 1)),
        shippingAddress: '789 Elm Street, City, State 98765',
        customerName: 'Lê Minh C',
        customerPhone: '+84 555 123 456',
      ),
      Order(
        id: 'ORD-004',
        items: [
          OrderItem(
            bookId: '5',
            bookTitle: 'The Catcher in the Rye',
            bookImage: 'assets/images/Logo.png',
            author: 'J.D. Salinger',
            price: 14.99,
            quantity: 1,
          ),
        ],
        totalAmount: 14.99,
        shippingFee: 5.00,
        status: OrderStatus.pending,
        orderDate: DateTime.now(),
        shippingAddress: '321 Pine Road, City, State 13579',
        customerName: 'Phạm Thị D',
        customerPhone: '+84 111 222 333',
      ),
    ];
  }

  List<Order> _getFilteredOrders(OrderStatus? status) {
    if (status == null) return _orders;
    return _orders.where((order) => order.status == status).toList();
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.confirmed:
        return Colors.blue;
      case OrderStatus.processing:
        return Colors.purple;
      case OrderStatus.shipped:
        return Colors.indigo;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

  IconData _getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Icons.pending;
      case OrderStatus.confirmed:
        return Icons.check_circle_outline;
      case OrderStatus.processing:
        return Icons.autorenew;
      case OrderStatus.shipped:
        return Icons.local_shipping;
      case OrderStatus.delivered:
        return Icons.done_all;
      case OrderStatus.cancelled:
        return Icons.cancel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text(
          'Đơn hàng của tôi',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _loadOrders, icon: const Icon(Icons.refresh)),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          tabs: const [
            Tab(text: 'Tất cả'),
            Tab(text: 'Chờ xác nhận'),
            Tab(text: 'Đang xử lý'),
            Tab(text: 'Đang giao'),
            Tab(text: 'Đã giao'),
            Tab(text: 'Đã hủy'),
          ],
        ),
      ),
      body:
          _isLoading
              ? const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              )
              : TabBarView(
                controller: _tabController,
                children: [
                  _buildOrdersList(_getFilteredOrders(null)),
                  _buildOrdersList(_getFilteredOrders(OrderStatus.pending)),
                  _buildOrdersList(_getFilteredOrders(OrderStatus.processing)),
                  _buildOrdersList(_getFilteredOrders(OrderStatus.shipped)),
                  _buildOrdersList(_getFilteredOrders(OrderStatus.delivered)),
                  _buildOrdersList(_getFilteredOrders(OrderStatus.cancelled)),
                ],
              ),
    );
  }

  Widget _buildOrdersList(List<Order> orders) {
    if (orders.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        _loadOrders();
      },
      color: AppColors.primary,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return _buildOrderCard(order);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Chưa có đơn hàng nào',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Hãy đặt mua những cuốn sách yêu thích\ncủa bạn ngay hôm nay!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Navigate to home or books screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'Khám phá sách',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Order header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Đơn hàng #${order.id}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Đặt ngày: ${_formatDate(order.orderDate)}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order.status).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getStatusIcon(order.status),
                        size: 14,
                        color: _getStatusColor(order.status),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        order.statusText,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor(order.status),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Order items
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order.items.length,
            itemBuilder: (context, index) {
              final item = order.items[index];
              return _buildOrderItem(item);
            },
          ),
          const Divider(height: 1),
          // Order summary and actions
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng cộng (${order.items.length} sản phẩm):',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.text,
                      ),
                    ),
                    Text(
                      '\$${order.finalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _showOrderDetails(order),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Chi tiết',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (order.status == OrderStatus.delivered)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _showReviewDialog(order),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Đánh giá',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    else if (order.status == OrderStatus.shipped)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _trackOrder(order),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Theo dõi',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    else if (order.status == OrderStatus.pending)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _cancelOrder(order),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Hủy đơn',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(OrderItem item) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(item.bookImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.bookTitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Tác giả: ${item.author}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      'x${item.quantity}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showOrderDetails(Order order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.7,
            maxChildSize: 0.9,
            minChildSize: 0.5,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Chi tiết đơn hàng #${order.id}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailSection('Thông tin đơn hàng', [
                              _buildDetailRow('Mã đơn hàng', order.id),
                              _buildDetailRow(
                                'Ngày đặt',
                                _formatDate(order.orderDate),
                              ),
                              _buildDetailRow('Trạng thái', order.statusText),
                              if (order.trackingNumber != null)
                                _buildDetailRow(
                                  'Mã vận đơn',
                                  order.trackingNumber!,
                                ),
                              if (order.deliveryDate != null)
                                _buildDetailRow(
                                  'Ngày giao',
                                  _formatDate(order.deliveryDate!),
                                ),
                            ]),
                            const SizedBox(height: 24),
                            _buildDetailSection('Thông tin giao hàng', [
                              _buildDetailRow(
                                'Tên người nhận',
                                order.customerName,
                              ),
                              _buildDetailRow(
                                'Số điện thoại',
                                order.customerPhone,
                              ),
                              _buildDetailRow('Địa chỉ', order.shippingAddress),
                            ]),
                            const SizedBox(height: 24),
                            _buildDetailSection('Chi tiết thanh toán', [
                              _buildDetailRow(
                                'Tiền hàng',
                                '\$${order.totalAmount.toStringAsFixed(2)}',
                              ),
                              _buildDetailRow(
                                'Phí vận chuyển',
                                '\$${order.shippingFee.toStringAsFixed(2)}',
                              ),
                              if (order.discount > 0)
                                _buildDetailRow(
                                  'Giảm giá',
                                  '-\$${order.discount.toStringAsFixed(2)}',
                                ),
                              const Divider(),
                              _buildDetailRow(
                                'Tổng cộng',
                                '\$${order.finalAmount.toStringAsFixed(2)}',
                                isTotal: true,
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: AppColors.text,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? AppColors.primary : AppColors.text,
            ),
          ),
        ],
      ),
    );
  }

  void _trackOrder(Order order) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Theo dõi đơn hàng'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Mã vận đơn: ${order.trackingNumber ?? "N/A"}'),
                const SizedBox(height: 16),
                const Text(
                  'Đơn hàng của bạn đang trên đường giao đến địa chỉ đã đăng ký.',
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Đóng'),
              ),
            ],
          ),
    );
  }

  void _cancelOrder(Order order) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Hủy đơn hàng'),
            content: const Text('Bạn có chắc chắn muốn hủy đơn hàng này?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Không'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Đơn hàng đã được hủy thành công'),
                    ),
                  );
                },
                child: const Text(
                  'Hủy đơn',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  void _showReviewDialog(Order order) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Đánh giá đơn hàng'),
            content: const Text('Tính năng đánh giá sẽ được cập nhật sớm!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Đóng'),
              ),
            ],
          ),
    );
  }
}
