import 'package:flutter/material.dart';
import 'api_movie.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<dynamic>? _movies;

  @override
  void initState() {
    super.initState();
    _fetchPopularMovies(); // Panggil metode yang Anda inginkan secara default
  }

  Future<void> _fetchPopularMovies() async {
    setState(() {
      _movies = MovieDBApi.getPopularMovies();
    });
  }

  Future<void> _fetchNowPlayingMovies() async {
    setState(() {
      _movies = MovieDBApi.getNowPlayingMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies List'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PopularMoviesScreen()),
                );
              },
              child: Text('Popular Movies'),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NowPlayingMoviesScreen()),
                );
              },
              child: Text('Now Playing'),
            ),
          ),
        ],
      ),
    );
  }
}

class PopularMoviesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: FutureBuilder<dynamic>(
        future: MovieDBApi.getPopularMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final movies = snapshot.data['results'];
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  title: Text(movie['title']),
                  subtitle: Text(movie['overview']),
                  leading: Image.network(
                      'https://image.tmdb.org/t/p/w500${movie['poster_path']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class NowPlayingMoviesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Movies'),
      ),
      body: FutureBuilder<dynamic>(
        future: MovieDBApi.getNowPlayingMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final movies = snapshot.data['results'];
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  title: Text(movie['title']),
                  subtitle: Text(movie['overview']),
                  leading: Image.network(
                      'https://image.tmdb.org/t/p/w500${movie['poster_path']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
