import 'package:flutter/material.dart';
import 'src/data/conection.dart'; // Importa la función de inicialización de Firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase(); // Inicializa Firebase antes de arrancar la app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Firebase Connection'),
        ),
        body: Center(
          child: Text('Firebase initialized successfully!'),
        ),
      ),
    );
  }
}
