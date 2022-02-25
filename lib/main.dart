import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/models/movie.dart';
import 'package:flutter_project/widgets/moviesWidget.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(App());
}

class App extends StatefulWidget {

  @override
  _App createState() => _App();
}

class _App extends State<App>{

  List<Movie> _movies = <Movie>[];
  final _saved = <Movie>{};
  final _biggerFont = const TextStyle(fontSize: 18);

@override
  void initState() {
    super.initState();
    _populateAllMovies();
  }

  void _populateAllMovies() async {
    final movies = await _fetchAllMovies();
    setState(() {
      _movies = movies;
    }
    );
  }

Future<List<Movie>> _fetchAllMovies() async {
 final response = await http.get(Uri.parse('https://www.omdbapi.com/?s=love&page=2&apikey=edf8e4ac'));

 if(response.statusCode == 200){
    final result = jsonDecode(response.body);
    Iterable list = result["Search"];
    return list.map((movie) => Movie.fromJson(movie)).toList();
 } else {
   throw Exception("Failed to load movies");
 }
}

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Movies to watch ASAP',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Movies to watch ASAP")
        ),
        body: MoviesWidget(movies: _movies)
      ),
    );
  }
}

