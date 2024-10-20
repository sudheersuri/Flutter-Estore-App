import 'package:flutter/material.dart';
import 'package:practice/pages/addresses.dart';
import 'package:practice/pages/profile.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String searchQuery = ''; // To store the search query

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          'Account Settings',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
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
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  // Update search query and refresh UI
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            const Divider(height: 0.5),
            ..._getFilteredSettings(),
          ],
        ),
      ),
    );
  }

  // Filter settings based on the search query
  List<ListTile> _getFilteredSettings() {
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
        "icon": Icons.home_outlined,
        "title": "Addresses",
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

    // Filter settings based on search query
    List<Map<String, dynamic>> filteredOptions = settingsOptions
        .where((setting) =>
            setting["title"].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    // Build ListTiles from filtered settings
    return filteredOptions.map((setting) {
      return ListTile(
        leading: Icon(setting["icon"]),
        title: Text(setting["title"]),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          if(setting["title"] == "Account") {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Profile(),
              ),
            );
          }
          else if(setting["title"] == "Addresses") {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Addresses(),
              ),
            );
          }
        },
      );
    }).toList();
  }
}
