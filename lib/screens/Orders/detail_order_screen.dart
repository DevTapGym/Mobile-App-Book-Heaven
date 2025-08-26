import 'package:flutter/material.dart';
import 'package:heaven_book_app/themes/app_colors.dart';
import 'package:heaven_book_app/widgets/appbar_custom_widget.dart';

class DetailOrderScreen extends StatelessWidget {
  const DetailOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustomWidget(title: 'Order Details'),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primary, Colors.white],
            stops: [0.3, 0.3],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Colors.white,
                  margin: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 14, 14, 4),
                        child: _statusSection(),
                      ),
                      Container(
                        height: 6,
                        width: double.infinity,
                        color: AppColors.background,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: _shippingAddressSection(),
                      ),
                      Container(
                        height: 6,
                        width: double.infinity,
                        color: AppColors.background,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: _itemsSection(),
                      ),
                      Container(
                        height: 6,
                        width: double.infinity,
                        color: AppColors.background,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: _orderSummarySection(),
                      ),
                      Container(
                        height: 6,
                        width: double.infinity,
                        color: AppColors.background,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: _orderDetailsSection(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _statusSection() {
    final List<Map<String, dynamic>> statusHistory = [
      {'status': 'Delivered', 'time': '13:00 07-12-2024'},
      {'status': 'Shipping', 'time': '08:00 05-12-2024'},
      {'status': 'Processing', 'time': '18:15 04-12-2024'},
    ];
    bool showAll = false;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Status Order:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            if (showAll) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    statusHistory.map((status) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    status['status'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    status['time'],
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ] else ...[
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            statusHistory.first['status'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            statusHistory.first['time'],
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Center(
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    showAll = !showAll;
                  });
                },
                icon: Icon(
                  showAll ? Icons.expand_less : Icons.expand_more,
                  color: AppColors.primary,
                ),
                label: Text(
                  showAll ? 'Show less' : 'Show more',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _shippingAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shipping address:',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.location_on, color: Colors.blue),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '72/34, Đường Đức Hiền, Tây Thạnh, Tân Phú\nHuyện Hồng Tiến - 073713371',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _itemsSection() {
    return Column(
      children: [
        _buildOrderItem(
          title: 'A Brief History of Humankind',
          author: 'Yuval Noah Harari',
          price: 360000,
          quantity: 1,
          checkOnDelivery: true,
          freeBookmark: false,
        ),
        _buildOrderItem(
          title: 'Tuổi Trẻ Đáng Giá Bao Nhiêu',
          author: 'Rosie Nguyễn',
          price: 75000,
          quantity: 2,
          checkOnDelivery: true,
          freeBookmark: true,
        ),
      ],
    );
  }

  Widget _orderSummarySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order summary',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        _buildSummaryRow('Subtotal', '510,000 đ'),
        _buildSummaryRow('Shipping', '30,000 đ'),
        const Text('Discounts:', style: TextStyle(fontWeight: FontWeight.bold)),
        _buildSummaryRow('• Product Voucher', '-30,000 đ'),
        _buildSummaryRow('• Shipping Voucher', '-30,000 đ'),
        _buildSummaryRow('• Member Discount', '-20,000 đ'),
        const Divider(),
        _buildSummaryRow('Total', '460,000 đ', isBold: true),
      ],
    );
  }

  Widget _orderDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order details',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        _buildDetailRow('Order number', 'ORD-TI00904001'),
        _buildDetailRow('Order date', '12/12/2024 14:05'),
        _buildDetailRow('Payment Method', 'COD'),
        _buildDetailRow('Payment time', '16/12/2024 16:30'),
        _buildDetailRow('Delivery time', '16/12/2024 16:30'),
        TextButton(onPressed: () {}, child: const Text('Export Receipt >')),
      ],
    );
  }

  Widget _buildOrderItem({
    required String title,
    required String author,
    required int price,
    required int quantity,
    required bool checkOnDelivery,
    required bool freeBookmark,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 120,
              color: Colors.grey[200],
              child: const Icon(Icons.book, size: 40),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(author, style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text('${price.toString()} đ x $quantity'),
                      const Spacer(),
                      Text('${price * quantity} đ'),
                    ],
                  ),
                  if (checkOnDelivery) const Text('• Check on Delivery'),
                  if (freeBookmark) const Text('• Free Bookmark'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Add to cart button
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: () {},
                label: Text(
                  'Review',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Buy now button
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDark,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Buy Again',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
