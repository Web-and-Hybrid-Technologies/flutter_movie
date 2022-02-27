import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_project/widgets/moviesWidget.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);



  @override
  _App createState() => _App();
}

class _App extends State<App> {
  List<Movie> _movies = <Movie>[];
  final _suggestions = <Movie>[];
  final _saved = <Movie>{};

  @override
  void initState() {
    super.initState();
    _populateAllMovies();
  }

  void _populateAllMovies() async {
    final movies = await _fetchAllMovies();
    setState(() {
      _movies = movies;
    });
  }

  Future<List<Movie>> _fetchAllMovies() async {
    final response = await http.get(
        Uri.parse('https://www.omdbapi.com/?s=love&page=2&apikey=edf8e4ac'));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["Search"];
      return list.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Failed to load movies");
    }
  }
  

  
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
            (movie) {
              return ListTile(
                title: Text(
                  movie.title,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Favorites'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildMovieList(Movie movie) {
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
}

void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
            (movie) {
              return ListTile(
                title: Text(
                  movie.title,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Favorites'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies to watch ASAP',
      home: Scaffold(
          appBar: AppBar(
            title: Text("Movies to watch ASAP"),
            leading: Container(
              child: Image.asset('assets/flutter_logo.png', fit: BoxFit.cover),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.list),
                onPressed: _pushSaved,
                tooltip: 'Favorites',
              ),
            ],
          ),
          body: MoviesWidget(movies: _movies)),
    );
  }
}
