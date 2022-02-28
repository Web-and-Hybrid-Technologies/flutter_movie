import 'package:flutter/material.dart';
import 'package:flutter_project/models/movie.dart';

class MoviesWidget extends StatefulWidget {
  final List<Movie> movies;
  const MoviesWidget({Key? key, required this.movies}) : super(key: key);

  @override
  _MoviesWidget createState() => _MoviesWidget();
}

class _MoviesWidget extends State<MoviesWidget> {
  final _saved = <Movie>{};

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          final movie = widget.movies[index];
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
            onTap: () {
              setState(() {
                if (alreadySaved) {
                  _saved.remove(movie);
                } else {
                  _saved.add(movie);
                }
              });
            },
          );
        });
  }
}