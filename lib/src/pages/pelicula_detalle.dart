import 'package:fl_app_peliculas/src/models/actores_model.dart';
import 'package:fl_app_peliculas/src/models/pelicula_model.dart';
import 'package:fl_app_peliculas/src/providers/peliculas_provider.dart';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

class PeliculaDetalle extends StatelessWidget {
  const PeliculaDetalle({super.key});



  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context)!.settings.arguments as Pelicula;


    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar( pelicula ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox( height: 10.0 ),
                _posterTitulo( context, pelicula ),
                _descripcion( pelicula ),
                _descripcion( pelicula ),
                _descripcion( pelicula ),
                _descripcion( pelicula ),
                _crearCasting( pelicula )
              ]
            ),
          )
        ],
      )
    );
  }


  Widget _crearAppbar( Pelicula pelicula ){

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: FadeIn(
          delay: const Duration( milliseconds: 300 ),
          child: Padding(
            padding: const EdgeInsets.symmetric( horizontal: 8),
            child: Text(
              pelicula.title!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white, 
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        background: Hero(
          tag: pelicula.uniqueIdBanner,
          child: FadeInImage(
            image: NetworkImage( pelicula.getBackgroundImg() ),
            placeholder: const AssetImage('assets/img/loading.gif'),
            fadeInDuration: const Duration( milliseconds: 150),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula ){

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage( pelicula.getPosterImg() ),
                height: 150.0,
              ),
            ),
          ),
          const SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeIn(
                  delay: const Duration( milliseconds: 200 ),
                  child: Text(pelicula.title!, style: Theme.of(context).textTheme.headlineMedium, overflow: TextOverflow.clip ),
                ),
                
                FadeIn(
                  delay: const Duration( milliseconds: 400 ),
                  child: Text(pelicula.originalTitle!, style: Theme.of(context).textTheme.titleSmall, overflow: TextOverflow.ellipsis ),
                ),
                
                FadeIn(
                  delay: const Duration( milliseconds: 600 ),
                  child: Row(
                    children: <Widget>[
                      const Icon( Icons.star_border ),
                      Text( pelicula.voteAverage.toString(), style: Theme.of(context).textTheme.titleSmall )
                    ],
                  )
                )
                
              ],
            ),
          )
        ],
      ),
    );

  }


  Widget _descripcion( Pelicula pelicula ) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Text(
        pelicula.overview!,
      ),
    );

  }


  Widget _crearCasting( Pelicula pelicula ) {

    final peliProvider = PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {
        
        if( snapshot.hasData ) {
          return _crearActoresPageView( snapshot.data as List<Actor> );
        } else {
          return const Center(child: CircularProgressIndicator());
        }

      },
    );

  }

  Widget _crearActoresPageView( List<Actor> actores ) {

    return SizedBox(
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: PageController(
          viewportFraction: 0.3,
        ),
        itemCount: actores.length,
        itemBuilder: (context, i) =>_actorTarjeta( actores[i] ),
      ),
    );

  }

  Widget _actorTarjeta( Actor actor ) {
    return Container(
      margin: const EdgeInsets.only( left: 15),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage( actor.getFoto() ),
              placeholder: const AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              actor.name!,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      )
    );
  }


}