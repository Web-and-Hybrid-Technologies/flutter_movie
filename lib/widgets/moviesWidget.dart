import 'package:flutter/material.dart';
import 'package:flutter_project/models/movie.dart';

class MoviesWidget extends StatelessWidget {

  final List<Movie> movies;
  final _suggestions = <Movie>[];

  MoviesWidget({required this.movies});
  
  @override
  Widget build(BuildContext context) {


    return ListView.builder(
      padding: const EdgeInsets.all(16),
    
      itemBuilder: (context, index) {

        if (index.isOdd) {
        return const Divider();
      }

        final movie = movies[index];
        

        return ListTile(
          title: Text(movie.title)
        );
      }
    );


  }
}