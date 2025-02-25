import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myapp/route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vai uma dica aí?',
      debugShowCheckedModeBanner: false,
      initialRoute: "home",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LatLng? _currentLocation;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  // Method to center the map on the current location
  void _centerOnCurrentLocation() {
    if (_currentLocation != null) {
      _mapController.move(_currentLocation!, 14.5);
      _mapController.rotate(0);
    } else {
      _getCurrentLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var altura = constraints.maxHeight;
        var largura = constraints.maxWidth;
        const defaultLocation = LatLng(-21.77511, -43.37196);
        final initialLocation = _currentLocation ?? defaultLocation;

        return Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: (altura / 100 * 50) + 30,
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        initialCenter: initialLocation,
                        initialZoom: 14.5,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: initialLocation,
                              child: const Icon(
                                Icons.location_pin,
                                color: Color.fromARGB(255, 50, 50, 50),
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 40.0,
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: FittedBox(
                            child: FloatingActionButton(
                              onPressed:
                                  () => Navigator.pushNamed(context, 'menu'),
                              tooltip: 'Menu',
                              elevation: 2,
                              foregroundColor: const Color.fromARGB(
                                255,
                                239,
                                239,
                                239,
                              ),
                              backgroundColor: const Color.fromARGB(
                                255,
                                50,
                                50,
                                50,
                              ),
                              child: const Icon(Icons.menu),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: FittedBox(
                            child: FloatingActionButton(
                              onPressed:
                                  () => Navigator.pushNamed(context, 'perfil'),
                              tooltip: 'Perfil',
                              elevation: 2,
                              foregroundColor: Color.fromARGB(
                                255,
                                239,
                                239,
                                239,
                              ),
                              backgroundColor: Color.fromARGB(255, 50, 50, 50),
                              child: const Icon(Icons.person_outline),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: FittedBox(
                            child: FloatingActionButton(
                              onPressed: _centerOnCurrentLocation,
                              tooltip: 'Centralizar',
                              elevation: 2,
                              foregroundColor: Color.fromARGB(
                                255,
                                239,
                                239,
                                239,
                              ),
                              backgroundColor: Color.fromARGB(255, 50, 50, 50),
                              child: const Icon(Icons.my_location),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: altura / 100 * 50,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 50, 50, 50),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        // Suggested code may be subject to a license. Learn more: ~LicenseLog:1242285733.
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    color: Color.fromARGB(255, 239, 239, 239),
                                  ),

                                  child: Center(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.search_outlined),
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.send_outlined),
                                          onPressed: () {},
                                        ),
                                        hintText: 'Local ou Perfil',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Locais Próximos',
                                      style: TextStyle(
                                        color: Color.fromARGB(
                                          255,
                                          239,
                                          239,
                                          239,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => Navigator.pushNamed(context, 'local'),
                                      child: SizedBox(
                                        height: 80,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                  color: Color.fromARGB(
                                                    255,
                                                    239,
                                                    239,
                                                    239,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    8.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .shopping_bag_outlined,
                                                        color: Color.fromARGB(
                                                          255,
                                                          50,
                                                          50,
                                                          50,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              8.0,
                                                            ),
                                                        child: Text(
                                                          'Shopping Independência',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                  color: Color.fromARGB(
                                                    255,
                                                    239,
                                                    239,
                                                    239,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    8.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .sports_soccer_outlined,
                                                        color: Color.fromARGB(
                                                          255,
                                                          50,
                                                          50,
                                                          50,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              8.0,
                                                            ),
                                                        child: Text(
                                                          'Estádio Municipal',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                  color: Color.fromARGB(
                                                    255,
                                                    239,
                                                    239,
                                                    239,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    8.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.restaurant_outlined,
                                                        color: Color.fromARGB(
                                                          255,
                                                          50,
                                                          50,
                                                          50,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              8.0,
                                                            ),
                                                        child: Text(
                                                          'Restaurante Universitário',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Recentes',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 239, 239, 239),
                                    ),
                                  ),
                                  SizedBox(
                                    height: altura / 100 * 15,
                                    child: ListView(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.restore_outlined,
                                              color: Color.fromARGB(
                                                255,
                                                239,
                                                239,
                                                239,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: largura - 100,
                                                    child: Text(
                                                      'Universidade Federal de Juiz de Fora',
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          239,
                                                          239,
                                                          239,
                                                        ),
                                                        fontSize: 20,
                                                      ),
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: largura - 100,
                                                    child: Text(
                                                      'Campus Universitário, Rua José Lourenço Kelmer, s/n - São Pedro, Juiz de Fora - MG',
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          239,
                                                          239,
                                                          239,
                                                        ),
                                                        fontSize: 12,
                                                      ),
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.restore_outlined,
                                              color: Color.fromARGB(
                                                255,
                                                239,
                                                239,
                                                239,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: largura - 100,
                                                    child: Text(
                                                      'Drogaria Araujo',
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          239,
                                                          239,
                                                          239,
                                                        ),
                                                        fontSize: 20,
                                                      ),
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: largura - 100,
                                                    child: Text(
                                                      'Av. Pres. Costa e Silva, 1516 - São Pedro, Juiz de Fora - MG',
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          239,
                                                          239,
                                                          239,
                                                        ),
                                                        fontSize: 12,
                                                      ),
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.restore_outlined,
                                              color: Color.fromARGB(
                                                255,
                                                239,
                                                239,
                                                239,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: largura - 100,
                                                    child: Text(
                                                      'Bahamas São Pedro',
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          239,
                                                          239,
                                                          239,
                                                        ),
                                                        fontSize: 20,
                                                      ),
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: largura - 100,
                                                    child: Text(
                                                      'Rua José Lourenço, 710 - São Pedro, Juiz de Fora - MG, 36037-150',
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                          255,
                                                          239,
                                                          239,
                                                          239,
                                                        ),
                                                        fontSize: 12,
                                                      ),
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
