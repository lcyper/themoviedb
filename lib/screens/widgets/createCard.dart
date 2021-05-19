import 'package:flutter/material.dart';

import 'package:themoviedb/class/Movies.dart';
import 'package:themoviedb/screens/pages/movie_card_page.dart';

class CreateCard extends StatelessWidget {
  final Movies movie;

  CreateCard({
    Key key,
    @required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(
          top: 35.0,
          bottom: 0.0,
        ),
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: InkWell(
            key: Key(movie.id),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieCardPage(movie: movie),
                ),
              );
            },
            child: _cardMovieInfo(context),
          ),
        ),
      );

  Widget movieInfoOnly(BuildContext context, List<Widget> children) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Column(
        // scrollDirection: Axis.vertical,
        children: [
          _cardMovieInfo(context, isMovieInfo: true),
          for (var child in children)
            Padding(
              padding: EdgeInsets.all(15.0),
              child: child,
            )
        ],
      ),
    );
  }

  Widget _cardMovieInfo(BuildContext context, {bool isMovieInfo = false}) =>
      Hero(
        transitionOnUserGestures: true,
        tag: "movieInfo" + movie.id,
        child: Material(
          type: MaterialType.transparency,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentDirectional.topStart,
            children: [
              Positioned(
                top: -30.0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    15.0,
                    0.0,
                    15.0,
                    15.0,
                  ),
                  child: _moviePoster(isMovieInfo),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.3,
                  15.0,
                  15.0,
                  15.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            movie.title,
                            overflow: TextOverflow.fade,
                            maxLines: isMovieInfo ? 4 : 2,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        // Spacer(flex: 1),
                      ],
                    ),
                    Row(
                      children: [
                        if (movie.adult)
                          _outlinedBototn(
                            icon: Icons.explicit_outlined,
                            color: Colors.red,
                            text: "+18",
                          ),
                        if (movie.releaseDate != null)
                          _outlinedBototn(
                            icon: Icons.date_range,
                            color: Colors.black87,
                            text: movie.releaseDate.year.toString(),
                          ),
                        _outlinedBototn(
                          icon: Icons.star_rounded,
                          color: Colors.yellow[900],
                          text: movie.voteAverage, //+ '/10'
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        Movies().getGender(movie.gender),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Padding _outlinedBototn({IconData icon, Color color, String text}) => Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: OutlinedButton.icon(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          icon: Icon(
            icon,
            color: color,
          ),
          label: Text(
            text,
          ),
          onPressed: null,
        ),
      );

  Widget _moviePoster([bool isMovieInfo]) {
    var image = Image.network(
      movie.posterPath,
      alignment: Alignment.center,
      width: 90.0,
      cacheWidth: 90,
    );
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: isMovieInfo ? ImageOnMovieInfo(image: image, movie: movie) : image,
    );
  }
}

class ImageOnMovieInfo extends StatelessWidget {
  const ImageOnMovieInfo({
    Key key,
    @required this.image,
    @required this.movie,
  }) : super(key: key);

  final Image image;
  final Movies movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: image,
      onTap: () => showDialog(
        barrierColor: Colors.black87,
        context: context,
        builder: (context) => AlertDialog(
          elevation: 5.0,
          contentPadding: EdgeInsets.zero,
          // insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          // title: Text(movie.title),
          content: Container(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: InteractiveViewer(
              child: Image.network(
                movie.posterPath,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
