import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Add your form submission logic here
            },
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
