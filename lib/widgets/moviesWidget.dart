import 'package:flutter/material.dart';
import 'package:flutter_project/models/movie.dart';

class MoviesWidget extends StatelessWidget {
  final List<Movie> movies;
  final _saved = <Movie>{};

  MoviesWidget({required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          final alreadySaved = _saved.contains(movie);
          return ListTile(
            title: Text(
              movie.title,
            ),
            trailing: Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.red : null,
              semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
            ),
/*             onTap: () {
              setState(() {
                if (alreadySaved) {
                  _saved.remove(movie);
                } else {
                  _saved.add(movie);
                }
              });
            }, */
          );
        });
  }
}
