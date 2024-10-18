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
  const MyApp({super.key});

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

// Clase para representar un examen
class Examen {
  final String nombre;
  final String descripcion;
  final String imagen;
  final String fecha; // Año del examen

  Examen({
    required this.nombre,
    required this.descripcion,
    required this.imagen,
    required this.fecha,
  });
}

class ExamenesScreen extends StatefulWidget {
  const ExamenesScreen({super.key});

  @override
  _ExamenesScreenState createState() => _ExamenesScreenState();
}

class _ExamenesScreenState extends State<ExamenesScreen> {
  // TextEditingController para la barra de búsqueda
  TextEditingController _searchController = TextEditingController();

  // Listas de exámenes para cada sección
  List<Examen> cambridgeExamenes = [
    Examen(
      nombre: 'C1 Advanced (CAE)',
      descripcion: 'Examen avanzado de inglés.',
      imagen: 'images/CAE.jpg',
      fecha: '2024',
    ),
    Examen(
      nombre: 'C2 Proficiency (CPE)',
      descripcion: 'Examen de máximo nivel en inglés.',
      imagen: 'images/CPE.jpg',
      fecha: '2024',
    ),
    // Puedes agregar más exámenes aquí
  ];

  List<Examen> michiganExamenes = [
    Examen(
      nombre: 'ECCE',
      descripcion: 'Examen de competencia en inglés.',
      imagen: 'images/ECCE.jpg',
      fecha: '2024',
    ),
    Examen(
      nombre: 'ECPE',
      descripcion: 'Examen de dominio en inglés.',
      imagen: 'images/ECPE.jpg',
      fecha: '2024',
    ),
    // Puedes agregar más exámenes aquí
  ];

  List<Examen> toeflExamenes = [
    Examen(
      nombre: 'TOEFL iBT',
      descripcion: 'Examen por internet de inglés.',
      imagen: 'images/IBT.jpg',
      fecha: '2024',
    ),
    Examen(
      nombre: 'TOEFL ITP',
      descripcion: 'Examen en papel de inglés.',
      imagen: 'images/ITP.jpg',
      fecha: '2024',
    ),
    // Puedes agregar más exámenes aquí
  ];

  // Listas filtradas
  List<Examen> filteredCambridgeExamenes = [];
  List<Examen> filteredMichiganExamenes = [];
  List<Examen> filteredToeflExamenes = [];

  @override
  void initState() {
    super.initState();
    // Inicialmente, las listas filtradas son iguales a las listas originales
    filteredCambridgeExamenes = cambridgeExamenes;
    filteredMichiganExamenes = michiganExamenes;
    filteredToeflExamenes = toeflExamenes;

    // Añadimos un listener al controlador de búsqueda
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    // Limpiamos el controlador al disponer el widget
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    // Cada vez que cambia el texto de búsqueda, actualizamos las listas filtradas
    setState(() {
      String query = _searchController.text.toLowerCase();

      filteredCambridgeExamenes = cambridgeExamenes.where((examen) {
        return examen.nombre.toLowerCase().contains(query) ||
            examen.descripcion.toLowerCase().contains(query);
      }).toList();

      filteredMichiganExamenes = michiganExamenes.where((examen) {
        return examen.nombre.toLowerCase().contains(query) ||
            examen.descripcion.toLowerCase().contains(query);
      }).toList();

      filteredToeflExamenes = toeflExamenes.where((examen) {
        return examen.nombre.toLowerCase().contains(query) ||
            examen.descripcion.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Número de pestañas (Cambridge, Michigan, Toefl)
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Exámenes Internacionales'),
          centerTitle: true, // Para centrar el título
          backgroundColor: AppColors.color3, // Fondo celeste
          bottom: const TabBar(
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
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar',
                  prefixIcon: const Icon(Icons.search,
                      color: AppColors.color2), // Color del ícono de búsqueda
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: AppColors.color2), // Color del borde
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Pestaña de Cambridge
                  ExamenesList(examenes: filteredCambridgeExamenes),
                  // Pestaña de Michigan
                  ExamenesList(examenes: filteredMichiganExamenes),
                  // Pestaña de Toefl
                  ExamenesList(examenes: filteredToeflExamenes),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor:
              AppColors.color3, // Color de fondo de la barra inferior
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view,
                  color: AppColors.color2), // Ícono color2
              label: 'Menú',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: AppColors.color2), // Ícono color2
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_pin,
                  color: AppColors.color2), // Ícono color2
              label: 'Ubicación',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money,
                  color: AppColors.color2), // Ícono color2
              label: 'Precios',
            ),
          ],
          selectedItemColor: AppColors.color2, // Color del ítem seleccionado
          unselectedItemColor:
              AppColors.color1, // Color del ítem no seleccionado
          showUnselectedLabels:
              true, // Mostrar etiquetas de ítems no seleccionados
          showSelectedLabels: true, // Mostrar etiquetas de ítems seleccionados
        ),
      ),
    );
  }
}

// Widget que muestra la lista de exámenes
class ExamenesList extends StatelessWidget {
  final List<Examen> examenes;

  const ExamenesList({required this.examenes, super.key});

  @override
  Widget build(BuildContext context) {
    if (examenes.isEmpty) {
      return Center(
        child: Text(
          'No se encontraron exámenes',
          style: TextStyle(color: AppColors.color2, fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      itemCount: examenes.length, // Número de exámenes en la lista
      itemBuilder: (context, index) {
        final examen = examenes[index];
        return Card(
          margin: const EdgeInsets.all(8),
          color: AppColors.color1, // Color de fondo de la tarjeta
          child: ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: Image.asset(
                examen.imagen, // Ruta de la imagen del examen
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              examen.nombre,
              style: const TextStyle(color: AppColors.white),
            ),
            subtitle: Text(
              examen.descripcion,
              style: const TextStyle(color: AppColors.white),
            ),
            trailing: const Icon(Icons.arrow_forward_ios,
                color: AppColors.white), // Color del icono
          ),
        );
      },
    );
  }
}
