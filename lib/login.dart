import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LatLng? _currentLocation;
  final MapController _mapController = MapController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var altura = constraints.maxHeight;
        var largura = constraints.maxWidth;
        const defaultLocation = LatLng(-21.77511, -43.37196);
        final initialLocation = _currentLocation ?? defaultLocation;

        return Scaffold(
          body: Container(
            width: largura,
            decoration: BoxDecoration(color: Color.fromARGB(255, 50, 50, 50)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3507608146.
                Text('Vai Uma Dica Aí?', style: TextStyle(color: Colors.white, fontSize: 30)),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 60,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color.fromARGB(255, 239, 239, 239),
                          ),
                      
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Usuário',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 60,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color.fromARGB(255, 239, 239, 239),
                          ),
                      
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Senha',
                                ),
                              ),
                            ),
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
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, 'home'),
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 98, 181, 229),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Color.fromARGB(255, 50, 50, 50),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, 'cadastro'),
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 98, 181, 229),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Cadastrar',
                              style: TextStyle(
                                color: Color.fromARGB(255, 50, 50, 50),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
