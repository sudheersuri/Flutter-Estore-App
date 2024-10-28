import 'package:flutter/material.dart';
import 'package:practice/pages/add_edit_address.dart';

class Addresses extends StatefulWidget {
  const Addresses({super.key});

  @override
  State<Addresses> createState() => _AddressesState();
}

class _AddressesState extends State<Addresses> {
  final addresses = [
    {
      'id': 1,
      'name': 'Home',
      'address': '1234 Sans St.',
      'city': 'Financial district',
      'state': 'IN',
      'zip': '62701',
    },
    {
      'id': 2,
      'name': 'Work',
      'address': '5678 Madhapur St.',
      'city': 'Financial district',
      'state': 'IN',
      'zip': '62701',
    },
    {
      'id': 3,
      'name': 'Grandma\'s',
      'address': '9101 Ganesh St.',
      'city': 'Financial district',
      'state': 'IN',
      'zip': '62701',
    },
    {
      'id': 4,
      'name': 'School',
      'address': '1122 Villa St.',
      'city': 'Financial district',
      'state': 'IN',
      'zip': '62701',
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(
        scrolledUnderElevation: 0,
        titleSpacing: 2,
        title: Text('Addresses'),
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to the Sign-Up screen
              //material page route
              //updateState(ref, loggedInProvider, !isLoggedin);
              //material navigation to login
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddEditAddress()));
            },
            child: Padding(
              padding: const EdgeInsets.only(right:8.0),
              child: Text(
                'Add',
                style: TextStyle(color: Colors.black),
              ),
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
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final address = addresses[index];
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
                      subtitle: Text('${address['address']}\n${address['city']}, ${address['state']} ${address['zip']}'),
                      trailing: IconButton(
                        icon: Icon(Icons.edit, size: 16, color: Colors.grey),
                        onPressed: () {
                          
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddEditAddress(address: address)));
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
                child: const Text('Confirm address'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}