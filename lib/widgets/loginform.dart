import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Create a Form widget.
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}


class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool processed = false;
  @override
  void initState() {
    super.initState();
  }
  getEffectsList() {
    if(!processed) {
      return [
        MoveEffect(begin: const Offset(-400, 0), end: const Offset(0, 0), curve: Curves.easeInOut, duration: const Duration(milliseconds: 500)),
      ];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: getEffectsList(),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Email",
                hintTextDirection: TextDirection.ltr,
               
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter valid emailid';
                }
                return null;
              },  
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Username",
         
                hintTextDirection: TextDirection.ltr,
               
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter valid username';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(Colors.deepPurple),
                      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                    ),
                    icon: loading ? SizedBox(
                      height: 15, 
                      width: 15,
                      child: const CircularProgressIndicator(strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )) : null,
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      setState(() {
                        loading = true;
                        //wait for 5 seconds 
                        Future.delayed(const Duration(seconds: 5), () {
                          setState(() {
                            loading = false;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Processing Data')),
                              );
                              _formKey.currentState!.reset();
                              processed = true;
                          });
                        });
                      });
                      
                    },
                    label: Text(loading ? 'Submitting' : 'Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
