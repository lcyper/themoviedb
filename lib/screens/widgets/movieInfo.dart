import 'package:flutter/material.dart';
import 'package:themoviedb/class/Movies.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieInfo extends StatefulWidget {
  final Movies movie;
  MovieInfo({@required this.movie});

  @override
  _MovieInfoState createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  bool _isActorName = true;
  void _toggleActorName() {
    setState(() {
      _isActorName = !_isActorName;
    });
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: widget.movie.getMovies(id: widget.movie.id),
        builder: (context, snapshot) {
          // final _controller = YoutubePlayerController(
          //   initialVideoId: widget.movie.trailerId,
          //   flags: YoutubePlayerFlags(
          //     useHybridComposition: true,
          //   ),
          // );

          Widget _actors() => widget.movie.actors.length >= 1
              ? Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        _isActorName ? 'Actores:' : 'Personajes:',
                        textScaleFactor: 1.6,
                        // textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: widget.movie.actors
                            .map(
                              (actor) => Column(
                                children: [
                                  GestureDetector(
                                    onTap: _toggleActorName,
                                    child: Container(
                                      // color: Colors.red,
                                      margin: EdgeInsets.only(
                                        right: 12.0,
                                        left: 12.0,
                                      ),
                                      width: 80,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          alignment: Alignment.center,
                                          image: NetworkImage(actor.image),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    // height: 90.0,
                                    width: 90.0,
                                    child: Text(
                                      _isActorName
                                          ? actor.name
                                          : actor.character
                                              .replaceAll("/", " "),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.visible,
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                )
              : Container();

          Widget _trailerAndFavorite() => Row(
                // direction: Axis.horizontal,
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: widget.movie.trailerId != null
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  widget.movie.trailerId != null
                      ? TextButton(
                          child: Text('Ver Trailer'),
                          // child: Text(widget.movie.trailerId),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    // content: YoutubePlayer(
                                    //   controller: _controller,
                                    //   onReady: () {
                                    //     print('Player is ready.');
                                    //   },
                                    // ),
                                    );
                              },
                            );
                          },
                        )
                      : Container(),
                  IconButton(
                    onPressed: () => setState(() {
                      List<String> message = [
                        "Se a agregado a Favoritos",
                        "Se a eliminado de Favoritos"
                      ];
                      widget.movie.toggleFavorite();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            message[widget.movie.favorite == true ? 0 : 1]),
                        duration: Duration(seconds: 2),
                      ));
                    }),
                    icon: widget.movie.favorite
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(Icons.favorite_border),
                  )
                ],
              );

          return snapshot.hasData
              ? Column(
                  children: [
                    _trailerAndFavorite(),
                    _actors(),
                  ],
                )
              : Center(
                  child: LinearProgressIndicator(),
                );
        },
      );
}
