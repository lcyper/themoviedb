import 'package:flutter/material.dart';
import 'package:themoviedb/class/Movies.dart';
import 'package:themoviedb/screens/widgets/createCard.dart';
import 'package:themoviedb/screens/widgets/movieDescription.dart';
import 'package:themoviedb/screens/widgets/movieInfo.dart';

class MovieCardPage extends StatefulWidget {
  final Movies movie;

  const MovieCardPage({Key key, this.movie}) : super(key: key);

  @override
  _MovieCardPageState createState() => _MovieCardPageState();
}

class _MovieCardPageState extends State<MovieCardPage> {
  @override
  Widget build(BuildContext context) {
    // Movies().getMovies(id: movie.id, buildContext:context))
    return SafeArea(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Image.network(
              widget.movie.backdropPath,
              fit: BoxFit.fitWidth,
              alignment: Alignment.center,
              cacheHeight: 300,
              height: 200.0,
            ),
            // alignment: Alignment.topCenter,
            // height: MediaQuery.of(context).size.height - 100,
            margin: EdgeInsets.zero,
            // padding: EdgeInsets.zero,
          ),
          Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                automaticallyImplyLeading: false,
                // toolbarHeight: 40.0,
                // foregroundColor: Colors.black,
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      // size: 30.0,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(1.0),
                      minimumSize: Size.square(1.0),
                      fixedSize: Size(3, 3),
                      primary: Colors.black45,
                    ),
                  ),
                )),
            body: _buildWidget(context),
          ),
        ],
      ),
    );
  }

  Widget _buildWidget(BuildContext context) {
    final List<Widget> widgets = [
      if (widget.movie.description != "") MovieDescription(movie: widget.movie),
      MovieInfo(movie: widget.movie),
    ];
    return ListView(
      padding: EdgeInsets.only(top: 190.0),
      children: [
        CreateCard(movie: widget.movie).movieInfoOnly(context, widgets),
      ],
    );
  }
}
