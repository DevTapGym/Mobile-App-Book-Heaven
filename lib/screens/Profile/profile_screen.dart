import 'package:flutter/material.dart';
import 'package:heaven_book_app/themes/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> notificationSwitch = ValueNotifier<bool>(true);
    final ValueNotifier<String> selectedLanguage = ValueNotifier<String>('VN');

    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primary, centerTitle: true),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primary, AppColors.background],
            stops: [0.26, 0.26],
          ),
        ),
        padding: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 100.0, bottom: 12.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 4.0,
                        shadowColor: Colors.black38,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 70.0,
                            left: 16.0,
                            right: 16.0,
                            bottom: 16.0,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Huỳnh Công Tiến',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Text(
                                      'Premium',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'Tienhuynh30303@gmail.com',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 6.0),
                              Divider(
                                thickness: 1.5,
                                color: Colors.black54,
                                indent: 20,
                                endIndent: 20,
                              ),
                              SizedBox(height: 16.0),
                              ListTile(
                                leading: Icon(
                                  Icons.person,
                                  color: Colors.black54,
                                  size: 28,
                                ),
                                title: Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 17,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, '/edit-profile');
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.location_on,
                                  color: Colors.black54,
                                  size: 28,
                                ),
                                title: Text(
                                  'Shipping Address',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 17,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/shipping-address',
                                  );
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.card_giftcard,
                                  color: Colors.black54,
                                  size: 28,
                                ),
                                title: Text(
                                  'Rewards',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 17,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, '/reward');
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.lock,
                                  color: Colors.black54,
                                  size: 28,
                                ),
                                title: Text(
                                  'Change Password',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 17,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    'change-password',
                                  );
                                },
                              ),
                              SizedBox(height: 24.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, 0),
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          border: Border.all(
                            color: AppColors.primary,
                            width: 8.0,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(
                            'https://i.pinimg.com/1200x/15/b2/dd/15b2dde4fae9ee8f9b748b8b2a832415.jpg',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Card(
                  color: Colors.white,
                  elevation: 6.0,
                  shadowColor: Colors.black38,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: notificationSwitch,
                          builder: (context, value, child) {
                            return ListTile(
                              leading: Icon(
                                Icons.notifications,
                                color: Colors.black54,
                                size: 28,
                              ),
                              title: Text(
                                'Notifications',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  fontSize: 17,
                                ),
                              ),
                              trailing: Switch(
                                value: value,
                                onChanged: (bool newValue) {
                                  notificationSwitch.value = newValue;
                                },
                                inactiveThumbColor: Colors.black45,
                                activeColor: AppColors.primaryDark,
                              ),
                              onTap: () {
                                notificationSwitch.value =
                                    !notificationSwitch.value;
                              },
                            );
                          },
                        ),
                        ValueListenableBuilder<String>(
                          valueListenable: selectedLanguage,
                          builder: (context, value, child) {
                            return ListTile(
                              leading: Icon(
                                Icons.language,
                                color: Colors.black54,
                                size: 28,
                              ),
                              title: Text(
                                'Language',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  fontSize: 17,
                                ),
                              ),
                              trailing: Container(
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: 14.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black54,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: DropdownButton<String>(
                                  value: value,
                                  items:
                                      <String>['VN', 'EN'].map((
                                        String language,
                                      ) {
                                        return DropdownMenuItem<String>(
                                          value: language,
                                          child: Text(
                                            language,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      selectedLanguage.value = newValue;
                                    }
                                  },
                                  underline:
                                      SizedBox(), // Xóa gạch chân mặc định
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(
                            Icons.policy,
                            color: Colors.black54,
                            size: 28,
                          ),
                          title: Text(
                            'Terms of Service',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 17,
                            ),
                          ),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.repeat_on_rounded,
                            color: Colors.black54,
                            size: 28,
                          ),
                          title: Text(
                            'Return Policy',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 17,
                            ),
                          ),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.help,
                            color: Colors.black54,
                            size: 28,
                          ),
                          title: Text(
                            'Help & Feedback',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 17,
                            ),
                          ),
                          onTap: () {},
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 8.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 32.0,
                                vertical: 12.0,
                              ),
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: Text(
                              'Log Out',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
