import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
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
                    height: (altura / 100 * 60) + 30,
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
                                  () => Navigator.pushNamed(context, 'home'),
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
                      Container(
                        height: altura / 100 * 85,
                        width: largura,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 50, 50, 50),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                              onTap: () => Navigator.pushNamed(context, 'home'),
                              child: Icon(Icons.keyboard_arrow_down_rounded, color: Color.fromARGB(255, 182, 182, 182),)),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.person_outlined,
                                      size: 150,
                                      color: Color.fromARGB(255, 239, 239, 239),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Lana Silva',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 239, 239, 239),
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Juiz de Fora - MG',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 239, 239, 239),
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '20 anos',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 239, 239, 239),
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 50,
                                      width: 350,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 239, 239, 239),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(child: Text('Editar', style: TextStyle(color: Color.fromARGB(255, 50, 50, 50), fontSize: 20),)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () => Navigator.pushNamed(
                                          context,
                                          'login',
                                        ),
                                      child: Container(
                                        height: 50,
                                        width: 350,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 239, 239, 239),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Center(child: Text('Sair', style: TextStyle(color: Color.fromARGB(255, 50, 50, 50), fontSize: 20),)),
                                      ),
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
