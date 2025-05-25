import 'package:coba/customer_service_screen.dart';
import 'package:coba/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final box = GetStorage();
  bool isDarkMode = false;
  bool isNotificationOn = false;

  @override
  void initState() {
    super.initState();
    isDarkMode = box.read('isDarkMode') ?? false;
    isNotificationOn = box.read('isNotificationOn') ?? false;
  }

  void toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
      box.write('isDarkMode', value);
      Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
    });
  }

  void toggleNotification(bool value) {
    setState(() {
      isNotificationOn = value;
      box.write('isNotificationOn', value);
    });
  }

  void logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Konfirmasi'),
            content: const Text('Apakah Anda yakin ingin keluar?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Ya, Keluar'),
              ),
            ],
          ),
    );

    if (confirm == true) {
      box.remove('username');
      box.remove('password');
      Get.offAll(() => SplashScreen());
    }
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).textTheme.bodyMedium!.color,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            Center(child: Image.asset('assets/logo.png', height: 150)),
            const SizedBox(height: 20),
            _buildListTile(
              icon: Icons.notifications,
              title: 'Notification',
              trailing: Switch(
                value: isNotificationOn,
                onChanged: toggleNotification,
                activeColor: Colors.amber,
              ),
            ),
            _buildListTile(
              icon: Icons.light_mode,
              title: 'Dark Mode',
              trailing: Switch(
                value: isDarkMode,
                onChanged: toggleDarkMode,
                activeColor: Colors.amber,
              ),
            ),
            _buildListTile(icon: Icons.star_border, title: 'Rate App'),
            _buildListTile(icon: Icons.share, title: 'Share App'),
            _buildListTile(
              icon: Icons.support_agent,
              title: 'Customer Service',
              onTap: () => Get.to(() => const CustomerServiceScreen()),
            ),
            _buildListTile(icon: Icons.logout, title: 'Log out', onTap: logout),
          ],
        ),
      ),
    );
  }
}
