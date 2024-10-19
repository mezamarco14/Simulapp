import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'register.dart';  // Importa la página de registro
import 'examlist.dart';  // Importa la página de examlist

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> loginUser() async {
    try {
      // Iniciar sesión con Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Obtener datos adicionales del usuario desde Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        print("User data: ${userDoc.data()}");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Login successful')));

        // Redirigir a la página de lista de exámenes
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ExamenesScreen()),  // Cambia ExamList por ExamenesScreen
        );
      } else {
        print("User not found in Firestore.");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('User not found in Firestore')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: loginUser,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                // Navegar a la página de registro
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text('No account? Register here'),
            ),
          ],
        ),
      ),
    );
  }
}
