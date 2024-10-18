import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class AppColors {
  static const Color color1 = Color(0xFF377899); // Color 1
  static const Color color2 = Color(0xFF1F4355); // Color 2
  static const Color color3 = Color(0xFF52B6E6); // Color 3 (Celeste)
  static const Color white = Colors.white; // Color blanco
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExamenesScreen(),
      theme: ThemeData(
        primaryColor: AppColors.color1, // Color primario
        scaffoldBackgroundColor: AppColors.white, // Color de fondo
      ),
    );
  }
}

class ExamenesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Número de pestañas (Cambridge, Michigan, Toefl)
      child: Scaffold(
        appBar: AppBar(
          title: Text('Examenes internacionales'),
          centerTitle: true, // Para centrar el título
          backgroundColor: AppColors.color3, // Fondo celeste
          bottom: TabBar(
            tabs: [
              Tab(text: 'Cambridge'),
              Tab(text: 'Michigan'),
              Tab(text: 'Toefl'),
            ],
            indicatorColor: AppColors.color2, // Color del indicador de pestañas
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search,
                      color: AppColors.color2), // Color del ícono de búsqueda
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: AppColors.color2), // Color del borde
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Pestaña de Cambridge
                  ExamenesList(),
                  // Pestaña de Michigan
                  ExamenesList(),
                  // Pestaña de Toefl
                  ExamenesList(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.color3, // Color de fondo de la barra inferior
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view, color: AppColors.color2), // Ícono color2
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: AppColors.color2), // Ícono color2
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_pin, color: AppColors.color2), // Ícono color2
              label: 'Ubicación',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money, color: AppColors.color2), // Ícono color2
              label: 'Precios',
            ),
          ],
          selectedItemColor: AppColors.color2, // Color del ítem seleccionado
          unselectedItemColor: AppColors.color1, // Color del ítem no seleccionado
          showUnselectedLabels: true, // Mostrar etiquetas de ítems no seleccionados
          showSelectedLabels: true, // Mostrar etiquetas de ítems seleccionados
        ),
      ),
    );
  }
}

// Widget que simula una lista de exámenes
class ExamenesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Número de exámenes en la lista
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(8),
          color: AppColors.color1, // Color de fondo de la tarjeta
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              child: Image.asset(
                'assets/exam_image.png', // Asegúrate de reemplazar con la ruta de la imagen real
                fit: BoxFit.cover,
              ),
            ),
            title: Text('Examen ${index + 1}',
                style: TextStyle(color: AppColors.white)), // Color del texto
            subtitle: Text('Descripción del examen...',
                style: TextStyle(color: AppColors.white)), // Color del texto
            trailing: Icon(Icons.arrow_forward_ios,
                color: AppColors.white), // Color del icono
          ),
        );
      },
    );
  }
}
