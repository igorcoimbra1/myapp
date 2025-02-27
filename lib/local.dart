import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class Local extends StatefulWidget {
  const Local({super.key});

  @override
  State<Local> createState() => _LocalState();
}

class _LocalState extends State<Local> {
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
                        width: largura,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 50, 50, 50),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, 'home'),
                              child: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Color.fromARGB(255, 182, 182, 182),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.shopping_bag_outlined,
                                      size: 80,
                                      color: Color.fromARGB(255, 182, 182, 182),
                                    ),
                                    SizedBox(
                                      width: largura * 0.65,
                                      child: Text(
                                        'Shopping Independência',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                            255,
                                            182,
                                            182,
                                            182,
                                          ),
                                          fontSize: 30,
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Campus Universitário, Rua José Lourenço Kelmer, s/n - São Pedro, Juiz de Fora - MG',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 239, 239, 239),
                                      fontSize: 12,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: largura,
                              height: altura * 0.4,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 50, 50, 50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                      0.3,
                                    ), // Cor da sombra com opacidade
                                    spreadRadius:
                                        3, // O quão grande a sombra se espalha
                                    blurRadius:
                                        7, // O quão borrada a sombra está
                                    offset: Offset(
                                      0,
                                      0,
                                    ), // Deslocamento da sombra (x, y)
                                  ),
                                ],
                              ),
                              child: ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 66, 66, 66),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.3,
                                            ), // Cor da sombra com opacidade
                                            spreadRadius:
                                                3, // O quão grande a sombra se espalha
                                            blurRadius:
                                                7, // O quão borrada a sombra está
                                            offset: Offset(
                                              0,
                                              3,
                                            ), // Deslocamento da sombra (x, y)
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.person_outline,
                                              color: Color.fromARGB(
                                                255,
                                                239,
                                                239,
                                                239,
                                              ),
                                              size: 40,
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            right: 8.0,
                                                          ),
                                                      child: Text(
                                                        'Lana Silva',
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                            255,
                                                            182,
                                                            182,
                                                            182,
                                                          ),
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          color: Color.fromARGB(
                                                            255,
                                                            239,
                                                            239,
                                                            239,
                                                          ),
                                                          size: 15,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color: Color.fromARGB(
                                                            255,
                                                            239,
                                                            239,
                                                            239,
                                                          ),
                                                          size: 15,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color: Color.fromARGB(
                                                            255,
                                                            239,
                                                            239,
                                                            239,
                                                          ),
                                                          size: 15,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color: Color.fromARGB(
                                                            255,
                                                            239,
                                                            239,
                                                            239,
                                                          ),
                                                          size: 15,
                                                        ),
                                                        Icon(
                                                          Icons.star_outline,
                                                          color: Color.fromARGB(
                                                            255,
                                                            239,
                                                            239,
                                                            239,
                                                          ),
                                                          size: 15,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: SizedBox(
                                                  width: largura * 0.75,
                                                  child: Text(
                                                    'Ótima variedade de lojas, ambiente agradável e uma praça de alimentação com muitas opções.',
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
                                                    overflow: TextOverflow.clip,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 66, 66, 66),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.3,
                                            ), // Cor da sombra com opacidade
                                            spreadRadius:
                                                3, // O quão grande a sombra se espalha
                                            blurRadius:
                                                7, // O quão borrada a sombra está
                                            offset: Offset(
                                              0,
                                              3,
                                            ), // Deslocamento da sombra (x, y)
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.person_outline,
                                              color: Color.fromARGB(
                                                255,
                                                239,
                                                239,
                                                239,
                                              ),
                                              size: 40,
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            right: 8.0,
                                                          ),
                                                      child: Text(
                                                        'Igor Titoneli',
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                            255,
                                                            182,
                                                            182,
                                                            182,
                                                          ),
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          color: Color.fromARGB(
                                                            255,
                                                            239,
                                                            239,
                                                            239,
                                                          ),
                                                          size: 15,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color: Color.fromARGB(
                                                            255,
                                                            239,
                                                            239,
                                                            239,
                                                          ),
                                                          size: 15,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color: Color.fromARGB(
                                                            255,
                                                            239,
                                                            239,
                                                            239,
                                                          ),
                                                          size: 15,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color: Color.fromARGB(
                                                            255,
                                                            239,
                                                            239,
                                                            239,
                                                          ),
                                                          size: 15,
                                                        ),
                                                        Icon(
                                                          Icons.star_outline,
                                                          color: Color.fromARGB(
                                                            255,
                                                            239,
                                                            239,
                                                            239,
                                                          ),
                                                          size: 15,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: SizedBox(
                                                  width: largura * 0.75,
                                                  child: Text(
                                                    'Fomos muito bem atendidos em todas as lojas que visitamos, é bem localizado, seguro, e a praça de alimentação tem bastante variedade.',
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
                                                    overflow: TextOverflow.clip,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 66, 66, 66),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.3,
                                            ), // Cor da sombra com opacidade
                                            spreadRadius:
                                                3, // O quão grande a sombra se espalha
                                            blurRadius:
                                                7, // O quão borrada a sombra está
                                            offset: Offset(
                                              0,
                                              3,
                                            ), // Deslocamento da sombra (x, y)
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.person_outline,
                                              color: Color.fromARGB(
                                                255,
                                                239,
                                                239,
                                                239,
                                              ),
                                              size: 40,
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            right: 8.0,
                                                          ),
                                                      child: Text(
                                                        'Gabriel Tavares',
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                            255,
                                                            182,
                                                            182,
                                                            182,
                                                          ),
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          color: Color.fromARGB(
                                                            255,
                                                            239,
                                                            239,
                                                            239,
                                                          ),
                                                          size: 15,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color: Color.fromARGB(
                                                            255,
                                                            239,
                                                            239,
                                                            239,
                                                          ),
                                                          size: 15,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color: Color.fromARGB(
                                                            255,
                                                            239,
                                                            239,
                                                            239,
                                                          ),
                                                          size: 15,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color: Color.fromARGB(
                                                            255,
                                                            239,
                                                            239,
                                                            239,
                                                          ),
                                                          size: 15,
                                                        ),
                                                        Icon(
                                                          Icons.star_outline,
                                                          color: Color.fromARGB(
                                                            255,
                                                            239,
                                                            239,
                                                            239,
                                                          ),
                                                          size: 15,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: SizedBox(
                                                  width: largura * 0.75,
                                                  child: Text(
                                                    'Fácil acesso, muitas lojas, praça de alimentação variada e ambientes limpos. Super recomendo!.',
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
                                                    overflow: TextOverflow.clip,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 66, 66, 66),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.3,
                                            ), // Cor da sombra com opacidade
                                            spreadRadius:
                                                3, // O quão grande a sombra se espalha
                                            blurRadius:
                                                7, // O quão borrada a sombra está
                                            offset: Offset(
                                              0,
                                              3,
                                            ), // Deslocamento da sombra (x, y)
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.person_outline,
                                              color: Color.fromARGB(
                                                255,
                                                239,
                                                239,
                                                239,
                                              ),
                                              size: 40,
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            right: 8.0,
                                                          ),
                                                      child: Text(
                                                        'Igor Coimbra',
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                            255,
                                                            182,
                                                            182,
                                                            182,
                                                          ),
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          color: Color.fromARGB(
                                                            255,
                                                            239,
                                                            239,
                                                            239,
                                                          ),
                                                          size: 15,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color: Color.fromARGB(
                                                            255,
                                                            239,
                                                            239,
                                                            239,
                                                          ),
                                                          size: 15,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color: Color.fromARGB(
                                                            255,
                                                            239,
                                                            239,
                                                            239,
                                                          ),
                                                          size: 15,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color: Color.fromARGB(
                                                            255,
                                                            239,
                                                            239,
                                                            239,
                                                          ),
                                                          size: 15,
                                                        ),
                                                        Icon(
                                                          Icons.star_outline,
                                                          color: Color.fromARGB(
                                                            255,
                                                            239,
                                                            239,
                                                            239,
                                                          ),
                                                          size: 15,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: SizedBox(
                                                  width: largura * 0.75,
                                                  child: Text(
                                                    'Achei que o shopping poderia ter mais opções de lojas e restaurantes, mas no geral é um bom lugar para fazer compras.',
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
                                                    overflow: TextOverflow.clip,
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
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.star_outline),
                                          Text(
                                            'Avaliar',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                255,
                                                50,
                                                50,
                                                50,
                                              ),
                                              fontSize: 20,
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
                                    height: 50,
                                    width: 350,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 239, 239, 239),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.favorite_outline),
                                          Text(
                                            'Favoritar',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                255,
                                                50,
                                                50,
                                                50,
                                              ),
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
            ],
          ),
        );
      },
    );
  }
}
