import 'package:flutter/material.dart';
import 'package:heaven_book_app/themes/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final bool isLoggedIn = true; // Simulate user login status
  final Map<String, dynamic> userProfile = {
    'name': 'Nguyen Van A',
    'email': 'nguyenvana@gmail.com',
    'phone': '+84 123 456 789',
    'avatar': '',
    'joinDate': 'January 2024',
    'totalBooks': 25,
    'totalSpent': 299.99,
    'membershipLevel': 'Gold Member',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with Profile Info
              _buildProfileHeader(),

              const SizedBox(height: 20),

              // Quick Stats
              _buildQuickStats(),

              const SizedBox(height: 24),

              // Menu Options
              _buildMenuOptions(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Column(
        children: [
          // Settings Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () => _showSettingsMenu(),
                icon: const Icon(Icons.settings, color: Colors.white, size: 24),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Avatar
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                child: CircleAvatar(
                  radius: 56,
                  backgroundColor: Colors.white.withValues(alpha: 0.3),
                  child:
                      userProfile['avatar'].isEmpty
                          ? Text(
                            userProfile['name'][0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                          : ClipRRect(
                            borderRadius: BorderRadius.circular(56),
                            child: Image.network(
                              userProfile['avatar'],
                              fit: BoxFit.cover,
                            ),
                          ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                    onTap: () => _editProfile(),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // User Info
          Text(
            userProfile['name'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            userProfile['email'],
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
            ),
            child: Text(
              userProfile['membershipLevel'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              icon: Icons.book_outlined,
              title: 'Books Owned',
              value: '${userProfile['totalBooks']}',
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              icon: Icons.monetization_on_outlined,
              title: 'Total Spent',
              value: '\$${userProfile['totalSpent']}',
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              icon: Icons.access_time,
              title: 'Member Since',
              value: userProfile['joinDate'],
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOptions() {
    final menuItems = [
      {
        'title': 'My Library',
        'subtitle': 'View your purchased books',
        'icon': Icons.library_books,
        'color': Colors.blue,
        'onTap': () => _navigateToMyLibrary(),
      },
      {
        'title': 'Purchase History',
        'subtitle': 'View all your orders',
        'icon': Icons.history,
        'color': Colors.green,
        'onTap': () => _navigateToPurchaseHistory(),
      },
      {
        'title': 'Wishlist',
        'subtitle': '12 books saved for later',
        'icon': Icons.favorite_border,
        'color': Colors.red,
        'onTap': () => _navigateToWishlist(),
      },
      {
        'title': 'Reading Progress',
        'subtitle': 'Track your reading journey',
        'icon': Icons.trending_up,
        'color': Colors.purple,
        'onTap': () => _navigateToReadingProgress(),
      },
      {
        'title': 'Notifications',
        'subtitle': 'Manage your notifications',
        'icon': Icons.notifications_outlined,
        'color': Colors.orange,
        'onTap': () => _navigateToNotifications(),
      },
      {
        'title': 'Account Settings',
        'subtitle': 'Update your personal information',
        'icon': Icons.person_outline,
        'color': Colors.teal,
        'onTap': () => _navigateToAccountSettings(),
      },
      {
        'title': 'Payment Methods',
        'subtitle': 'Manage cards and payment options',
        'icon': Icons.credit_card,
        'color': Colors.indigo,
        'onTap': () => _navigateToPaymentMethods(),
      },
      {
        'title': 'Help & Support',
        'subtitle': 'Get help with your account',
        'icon': Icons.help_outline,
        'color': Colors.cyan,
        'onTap': () => _navigateToHelpSupport(),
      },
      {
        'title': 'About',
        'subtitle': 'App version and information',
        'icon': Icons.info_outline,
        'color': Colors.grey,
        'onTap': () => _navigateToAbout(),
      },
      {
        'title': 'Sign Out',
        'subtitle': 'Sign out from your account',
        'icon': Icons.logout,
        'color': Colors.red,
        'onTap': () => _showSignOutDialog(),
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children:
            menuItems
                .map(
                  (item) => _buildMenuItem(
                    title: item['title'] as String,
                    subtitle: item['subtitle'] as String,
                    icon: item['icon'] as IconData,
                    color: item['color'] as Color,
                    onTap: item['onTap'] as VoidCallback,
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _buildMenuItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSettingsMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Settings',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: const Text('Dark Mode'),
                  trailing: Switch(value: false, onChanged: (value) {}),
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Push Notifications'),
                  trailing: Switch(value: true, onChanged: (value) {}),
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('Language'),
                  subtitle: const Text('English'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
              ],
            ),
          ),
    );
  }

  void _editProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit profile functionality coming soon!')),
    );
  }

  void _navigateToMyLibrary() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigating to My Library...')),
    );
  }

  void _navigateToPurchaseHistory() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigating to Purchase History...')),
    );
  }

  void _navigateToWishlist() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Navigating to Wishlist...')));
  }

  void _navigateToReadingProgress() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigating to Reading Progress...')),
    );
  }

  void _navigateToNotifications() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigating to Notifications...')),
    );
  }

  void _navigateToAccountSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigating to Account Settings...')),
    );
  }

  void _navigateToPaymentMethods() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigating to Payment Methods...')),
    );
  }

  void _navigateToHelpSupport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigating to Help & Support...')),
    );
  }

  void _navigateToAbout() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('About Book Heaven'),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Version: 1.0.0'),
                SizedBox(height: 8),
                Text('Build: 1.0.0+1'),
                SizedBox(height: 8),
                Text('© 2024 Book Heaven App'),
                SizedBox(height: 16),
                Text('Your digital library for endless reading adventures.'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Sign Out'),
            content: const Text('Are you sure you want to sign out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Implement sign out logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Signed out successfully')),
                  );
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Sign Out'),
              ),
            ],
          ),
    );
  }
}
