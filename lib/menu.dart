import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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
                                  () => Navigator.pushNamed(context, 'home'),
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
                      Container(
                        height: altura / 100 * 85,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 50, 50, 50),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () => Navigator.pushNamed(context, 'home'),
                                child: Icon(Icons.keyboard_arrow_down_rounded, color: Color.fromARGB(255, 182, 182, 182),)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.star_outline, color: Color.fromARGB(255, 182, 182, 182),size: 30),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text('Minhas Avaliações', style: TextStyle(color: Color.fromARGB(255, 182, 182, 182), fontSize: 25),),
                                      )
                                    ]
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.favorite_outline, color: Color.fromARGB(255, 182, 182, 182), size: 30,),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text('Favoritos', style: TextStyle(color: Color.fromARGB(255, 182, 182, 182), fontSize: 25),),
                                      )
                                    ]
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.notifications_outlined, color: Color.fromARGB(255, 182, 182, 182),size: 30),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text('Notificações', style: TextStyle(color: Color.fromARGB(255, 182, 182, 182), fontSize: 25),),
                                      )
                                    ]
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.qr_code_2_outlined, color: Color.fromARGB(255, 182, 182, 182),size: 30),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text('Leitor QR Code', style: TextStyle(color: Color.fromARGB(255, 182, 182, 182), fontSize: 25),),
                                      )
                                    ]
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.support_agent_outlined, color: Color.fromARGB(255, 182, 182, 182),size: 30),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text('Suporte', style: TextStyle(color: Color.fromARGB(255, 182, 182, 182), fontSize: 25),),
                                      )
                                    ]
                                  ),
                                ]
                              ),
                            ),
                          ],
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
