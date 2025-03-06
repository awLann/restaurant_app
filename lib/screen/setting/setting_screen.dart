import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/local_notification_provider.dart';
import 'package:restaurant_app/provider/theme_prefs_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    context.read<LocalNotificationProvider>().loadReminder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              "Dark Mode",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing:
                Consumer<ThemePrefsProvider>(builder: (context, value, child) {
              final isDarkMode = value.themeMode == ThemeMode.dark;
              return Switch(
                  value: isDarkMode,
                  onChanged: (isDarkMode) {
                    value.setThemePrefs();
                  });
            }),
          ),
          ListTile(
            title: Text(
              "Daily Reminder Notification",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Consumer<LocalNotificationProvider>(
                builder: (context, value, child) {
              return Switch(
                  value: value.isReminderEnabled,
                  onChanged: (isEnabled) async {
                    await value.setReminder(isEnabled);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(isEnabled
                          ? "Daily Reminder Enabled"
                          : "Daily Reminder Disabled"),
                      duration: const Duration(seconds: 2),
                    ));
                  });
            }),
          ),
        ],
      ),
    );
  }
}
