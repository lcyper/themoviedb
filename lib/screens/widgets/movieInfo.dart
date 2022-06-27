import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:themoviedb/provider/cacheApp.dart';

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
  Widget build(BuildContext context) {
    // var toggleFavorite = Provider.of<CacheApp>(context).toggleFavorite;
    var cacheDataApi = Provider.of<CacheApp>(context).cacheDataApi;

    return FutureBuilder(
      future: widget.movie
          .getMovies(id: widget.movie.id, cacheDataApi: cacheDataApi),
      builder: (context, snapshot) {
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
                                        : actor.character.replaceAll("/", " "),
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

        Widget _trailerAndFavorite() {
          // final _controller = YoutubePlayerController(
          //   initialVideoId: widget.movie.trailerId,
          //   flags: YoutubePlayerFlags(
          //     useHybridComposition: true,
          //     //   autoPlay: true,
          //     //   mute: true,
          //   ),
          // );
          return Row(
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
                              insetPadding: EdgeInsets.zero,
                              // content: YoutubePlayer(
                              //   controller: _controller,
                              //   showVideoProgressIndicator: true,
                              //   progressIndicatorColor: Colors.amber,
                              //   // progressColors: ProgressColors(
                              //   //     playedColor: Colors.amber,
                              //   //     handleColor: Colors.amberAccent,
                              //   // ),
                              //   onReady: () {
                              //     // _controller.addListener(listener);
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
                  Provider.of<CacheApp>(context, listen: false).toggleFavorite =
                      widget.movie;

                  // toggleFavorite = widget.movie;
                  // widget.movie.toggleFavorite();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text(message[widget.movie.favorite == true ? 0 : 1]),
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
        }

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
}
