import 'package:fl_app_peliculas/src/providers/peliculas_provider.dart';
import 'package:fl_app_peliculas/src/search/search_delegate.dart';
import 'package:fl_app_peliculas/src/widgets/card_swiper_widget.dart';
import 'package:fl_app_peliculas/src/widgets/movie_horizontal.dart';
import 'package:flutter/material.dart';


import '../models/pelicula_model.dart';

class HomePage extends StatelessWidget {

  final peliculasProvider = PeliculasProvider();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();


    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Películas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: const Icon( Icons.search ),
            onPressed: () {
              showSearch(
                context: context, 
                delegate: DataSearch(),
                // query: 'Hola'
                );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const SizedBox( height: 10),
            _swiperTarjetas(),
            const SizedBox( height: 20),
            _footer(context),
          ],
        ),
      )
       
    );
  }

  Widget _swiperTarjetas() {

    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        
        if ( snapshot.hasData ) {
          return CardSwiper( peliculas: snapshot.data! );
        } else {
          return const SizedBox(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
        
      },
    );



    


  }


  Widget _footer(BuildContext context){

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Populares', 
              style: Theme.of(context).textTheme.bodyLarge )
          ),
          const SizedBox(height: 5.0),

          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              
              if ( snapshot.hasData ) {
                return MovieHorizontal( 
                  peliculas: snapshot.data as List<Pelicula>?,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),

        ],
      ),
    );


  }

}