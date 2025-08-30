import 'package:flutter/material.dart';
import 'package:heaven_book_app/themes/app_colors.dart';

class AddressCardWidget extends StatelessWidget {
  final String title;
  final String name;
  final String phone;
  final String address;
  final bool isDefault;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AddressCardWidget({
    super.key,
    required this.title,
    required this.name,
    required this.phone,
    required this.address,
    this.isDefault = false,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0, top: 10.0, left: 18.0, right: 18.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              if (isDefault)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(1, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'Default',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.0),
          Text(
            '$name | $phone',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 4.0),
          Text(address, style: TextStyle(fontSize: 14)),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: IconButton(
                  icon: Icon(Icons.edit, color: Colors.white),
                  onPressed: onEdit,
                ),
              ),
              SizedBox(width: 12.0),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: IconButton(
                  icon: Icon(Icons.delete, color: Colors.white),
                  onPressed: onDelete,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
