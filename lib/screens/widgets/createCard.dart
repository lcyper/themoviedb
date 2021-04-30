import 'package:flutter/material.dart';

import 'package:themoviedb/class/Movies.dart';
import 'package:themoviedb/helpers/bordered_text.dart';
import 'package:themoviedb/screens/pages/movie_card_page.dart';

class CreateCard extends StatelessWidget {
  final Movies movie;
  final List<Widget> widgets;

  const CreateCard({Key key, @required this.movie, this.widgets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 85.0,
        bottom: 10.0,
      ),
      child: Card(
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
          child: Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentDirectional.topStart,
            children: [
              Positioned(
                bottom: 0.0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    15.0,
                    0.0,
                    15.0,
                    15.0,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: movie.posterPath != null
                        ? Image.network(
                            movie.posterPath,
                            alignment: Alignment.center,
                            width: 90.0,
                            cacheWidth: 90,
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Icon(Icons.error_outline),
                            ),
                          ),
                  ),
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
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        // Spacer(flex: 1),
               
                      ],                    ),
                    // Spacer(flex: 1),
                    Row(
                      children: [
                        if (movie.adult)
                          OutlinedButton.icon(
                            icon: Icon(
                              Icons.explicit_outlined,
                            ),
                            label: Text("+18"),
                            onPressed: null,
                          ),
                        OutlinedButton.icon(
                          icon: Icon(
                            Icons.date_range,
                            color: Colors.black87,
                          ),
                          label: Text(
                            movie.releaseDate.year.toString(),
                          ),
                          onPressed: null,
                        ),
                        OutlinedButton.icon(
                          icon: Icon(
                            Icons.star,
                            color: Colors.yellow[200],
                          ),
                          label: Text(movie.voteAverage),
                          onPressed: null,
                        ),
                      ],
                    ),
                    Text(
                      Movies().getGender(movie.gender),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // if (widgets != null) ...widgets,
            ],
          ),
        ),
      ),
    );
  }
}
