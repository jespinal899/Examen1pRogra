import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APP CEUTEC',
      initialRoute: '/',
      routes: {
        '/': (context) => MenuPrincipal(),
        '/noticias': (context) => EspacioNoticias(),
        '/tareas': (context) => ListaTareas(),
        '/monedas': (context) => CambioMonedas(),
        '/podcast': (context) => Podcast(),
      },
    );
  }
}

class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu Principal')),
      body: ListView(
        children: [
          ListTile(
            title: Text('Noticias'),
            onTap: () => Navigator.pushNamed(context, '/noticias'),
          ),
          ListTile(
            title: Text('Lista de Tareas'),
            onTap: () => Navigator.pushNamed(context, '/tareas'),
          ),
          ListTile(
            title: Text('Cambio de Monedas'),
            onTap: () => Navigator.pushNamed(context, '/monedas'),
          ),
          ListTile(
            title: Text('Podcast'),
            onTap: () => Navigator.pushNamed(context, '/podcast'),
          ),
        ],
      ),
    );
  }
}

class EspacioNoticias extends StatelessWidget {
  final List<Map<String, String>> noticias = [
    {
      'titulo': 'Actualización en el portal',
      'imagen': 'https://images.unsplash.com/photo-1516321310426-6b3dba1d02a4',
      'descripcion': 'Se han implementado mas equipo en los laboratodeio.'
    },
    {
      'titulo': 'Nueva Oferta Académica',
      'imagen': 'https://images.unsplash.com/photo-1514853647850-90b64dbe41d8',
      'descripcion': 'La universidad ofrece tutorias gratis para los estudiantes matriculados en el periodo Q4.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Noticias')),
      body: ListView.builder(
        itemCount: noticias.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(noticias[index]['imagen']!),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    noticias[index]['titulo']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(noticias[index]['descripcion']!),
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ListaTareas extends StatelessWidget {
  final List<String> tareas = [
    'Tarea 1: Investigación de administración de proyecto',
    'Foro: foro de bienvenida',
    'Examen: Matemáticas - Cálculo diferencial',
    'Tarea 2: Resumen de Literatura',
    'Examen: Química - Reacciones Orgánicas',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Tareas')),
      body: ListView.builder(
        itemCount: tareas.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              leading: Icon(Icons.check_box_outline_blank),
              title: Text(tareas[index]),
            ),
          );
        },
      ),
    );
  }
}

class CambioMonedas extends StatefulWidget {
  @override
  _CambioMonedasState createState() => _CambioMonedasState();
}

class _CambioMonedasState extends State<CambioMonedas> {
  String _monedaSeleccionada = 'Dólar';
  double _cantidadLempiras = 0.0;
  double _resultado = 0.0;

  final Map<String, double> _tasasCambio = {
    'Dólar': 0.041, 
    'Euro': 0.037,  
  };

  void _calcularCambio() {
    setState(() {
      _resultado = _cantidadLempiras * (_tasasCambio[_monedaSeleccionada] ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cambio de Monedas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: _monedaSeleccionada,
              onChanged: (String? nuevoValor) {
                setState(() {
                  _monedaSeleccionada = nuevoValor!;
                });
              },
              items: _tasasCambio.keys.map((String moneda) {
                return DropdownMenuItem<String>(
                  value: moneda,
                  child: Text(moneda),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Cantidad en Lempiras',
                border: OutlineInputBorder(),
              ),
              onChanged: (String valor) {
                setState(() {
                  _cantidadLempiras = double.tryParse(valor) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularCambio,
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            Text(
              'Resultado: $_resultado ${_monedaSeleccionada}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

// El widget Podcast añadido al final
class Podcast extends StatefulWidget {
  @override
  _PodcastState createState() => _PodcastState();
}

class _PodcastState extends State<Podcast> {
  bool _isPlaying = false;
  double _progress = 0.0;

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _onSliderChanged(double value) {
    setState(() {
      _progress = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Podcast'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen de portada
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1543995361-d8b7427f5e7a'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Título del podcast
            Text(
              'Título del Podcast',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            // Descripción
            Text(
              'Aquí va una breve descripción del podcast. EL FUTBOL SANA LA DEPRESION.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            // Barra de progreso
            Slider(
              value: _progress,
              onChanged: _onSliderChanged,
              min: 0,
              max: 1,
              activeColor: Colors.deepPurple,
              inactiveColor: Colors.deepPurple.withOpacity(0.5),
            ),
            SizedBox(height: 20),

            // Controles de reproducción
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous, size: 40, color: Colors.deepPurple),
                  onPressed: () {
                    // Acción para saltar al anterior
                  },
                ),
                IconButton(
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 50,
                    color: Colors.deepPurple,
                  ),
                  onPressed: _togglePlayPause,
                ),
                IconButton(
                  icon: Icon(Icons.skip_next, size: 40, color: Colors.deepPurple),
                  onPressed: () {
                    // Acción para saltar al siguiente
                  },
                ),
              ],
            ),
            SizedBox(height: 30),

            // Indicador de duración
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '0:00',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                Text(
                  '3:45', // Cambia esto según la duración real del podcast
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
