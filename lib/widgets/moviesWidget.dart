import 'package:flutter/material.dart';
import 'package:flutter_project/models/movie.dart';

class MoviesWidget extends StatelessWidget {

  final List<Movie> movies;

  MoviesWidget({required this.movies});
  
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: movies.length,
      itemBuilder: (context, index) {

        final movie = movies[index];

        return ListTile(
          title: Text(movie.title)
        );
      }
    );


  }
}