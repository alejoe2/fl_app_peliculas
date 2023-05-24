import 'package:fl_app_peliculas/src/pages/home_page.dart';
import 'package:fl_app_peliculas/src/pages/pelicula_detalle.dart';
import 'package:flutter/material.dart';


void main() => runApp(const MyApp());
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: '/',
      routes: {
        '/'       : ( BuildContext context ) => HomePage(),
        'detalle' : ( BuildContext context ) => const PeliculaDetalle(),
      },
    );
  }
}