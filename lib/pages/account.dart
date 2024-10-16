import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Account extends ConsumerStatefulWidget {
  const Account({super.key});

  @override
  ConsumerState<Account> createState() => _AccountState();
}

class _AccountState extends ConsumerState<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text('Account Settings', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search for a setting...",
                  filled: true,
                  fillColor: Colors.grey[200],
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const Divider(height: 0.5),
            ..._getSettings(context),
          ],
        ),
      ),
    );
  }

  List<ListTile> _getSettings(BuildContext context) {
    List<Map<String, dynamic>> settingsOptions = [
        {
          "icon": Icons.person_outline,
          "title": "Account",
        },
        {
          "icon": Icons.notifications_outlined,
          "title": "Notifications",
        },
        {
          "icon": Icons.visibility_outlined,
          "title": "Appearance",
        },
        {
          "icon": Icons.lock_outline,
          "title": "Privacy & Security",
        },
        {
          "icon": Icons.headset_mic_outlined,
          "title": "Help and Support",
        },
        {
          "icon": Icons.info_outline,
          "title": "About",
        },
    ];

    List<ListTile> settings = [];
    for (var setting in settingsOptions) {
      settings.add(
        ListTile(
      leading: Icon(setting["icon"]),
      title: Text(setting["title"]),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        // Navigate to corresponding settings page
      },
    )
      );
    }
    return settings;
  }
}
