import 'package:flutter/material.dart';



class LoginView extends StatelessWidget {
  const LoginView({super.key});

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (value) {
                
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (value) {
                
              },
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
 }
}
