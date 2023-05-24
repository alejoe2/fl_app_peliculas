import 'package:fl_app_peliculas/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';


class MovieHorizontal extends StatelessWidget {

  final List<Pelicula>? peliculas;
  final Function siguientePagina;

  MovieHorizontal({super.key,  required this.peliculas, required this.siguientePagina });

  final _pageController = PageController(
    // initialPage: 1,
    viewportFraction: 0.3
  );


  @override
  Widget build(BuildContext context) {
    
    final screenSize = MediaQuery.of(context).size;

    _pageController.addListener( () {

      if ( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200 ){
        siguientePagina();
      }

    });


    return SizedBox(
      height: screenSize.height * 0.21,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        itemCount: peliculas!.length,
        itemBuilder: ( context, i ) => _tarjeta(context, peliculas![i] ),
      ),
    );


  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {


    final tarjeta = Container(
        margin: const EdgeInsets.only(left: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage( pelicula.getPosterImg() ),
                  placeholder: const AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            SizedBox(
              width: 120,
              child: Text(
                pelicula.title!,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )
          ],
        ),
      );

    return GestureDetector(
      child: tarjeta,
      onTap: (){

        Navigator.pushNamed(context, 'detalle', arguments: pelicula );

      },
    );

  }



}
