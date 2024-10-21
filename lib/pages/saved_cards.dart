import 'package:flutter/material.dart';
import 'package:practice/pages/add_edit_address.dart';
import 'package:practice/pages/add_edit_card.dart';

class SavedCards extends StatefulWidget {
  const SavedCards({super.key});

  @override
  State<SavedCards> createState() => _SavedCardsState();
}

class _SavedCardsState extends State<SavedCards> {
  final cards = [
    {
      'id': 1,
      'name': 'XXXX-XXXX-XXXX-1234',
      'expiry': '12/23',
      'type': 'Visa',
    },
    {
      'id': 2,
      'name': 'XXXX-XXXX-XXXX-5678',
      'expiry': '12/24',
      'type': 'Mastercard',
    },
    {
      'id': 3,
      'name': 'XXXX-XXXX-XXXX-9101',
      'expiry': '12/25',
      'type': 'American Express',
    },
    {
      'id': 4,
      'name': 'XXXX-XXXX-XXXX-1122',
      'expiry': '12/26',
      'type': 'Discover',
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(
        titleSpacing: 2,
        title: Text('Saved cards'),
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to the Sign-Up screen
              //material page route
              //updateState(ref, loggedInProvider, !isLoggedin);
              //material navigation to login
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddEditCard()));
            },
            child: Text(
              'Add',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final address = cards[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[300]!,
                        ),
                      ),
                    ),
                    child: ListTile(
                      horizontalTitleGap: 0,
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(address['name']?.toString() ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
                      //add radio button in leading
                      leading: Container(
                        padding: const EdgeInsets.all(0), 
                        child: Radio(
                          fillColor: WidgetStateProperty.all(Colors.black),
                          value: address['id'],
                          groupValue: 1,
                          onChanged: (value) {
                            // Update the selected address
                            //updateState(ref, selectedAddressProvider, value);
                          },
                        ),
                      ),
                      subtitle: Text('${address['type']}\n${address['expiry']}'),
                      trailing: IconButton(
                        icon: Icon(Icons.edit, size: 16, color: Colors.grey),
                        onPressed: () {
                          
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddEditCard(card: address)));
                        },
                      ),
                    ),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle login logic
                  //updateState(ref, loggedInProvider, !isLoggedIn);
                  //go back to the previous screen
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.black, // Set the background color to black
                  foregroundColor: Colors.white, // Set the text color to white
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Update default card'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}