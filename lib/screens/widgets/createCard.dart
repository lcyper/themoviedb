import 'package:flutter/material.dart';

import 'package:themoviedb/class/Movies.dart';
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
        top: 35.0,
        bottom: 0.0,
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
                top: -30.0,
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
                          : Image.network(
                              'https://www.themoviedb.org/assets/2/apple-touch-icon-cfba7699efe7a742de25c28e08c38525f19381d31087c69e89d6bcb8e3c0ddfa.png',
                              alignment: Alignment.bottomCenter,
                              width: 90.0,
                              cacheWidth: 90,
                            )),
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
                      ],
                    ),
                    // Spacer(flex: 1),
                    Row(
                      children: [
                        if (movie.adult)
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: OutlinedButton.icon(
                              icon: Icon(
                                Icons.explicit_outlined,
                              ),
                              label: Text("+18"),
                              onPressed: null,
                            ),
                          ),
                        if (movie.releaseDate != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: OutlinedButton.icon(
                              icon: Icon(
                                Icons.date_range,
                                color: Colors.black87,
                              ),
                              label: Text(
                                movie.releaseDate.year.toString(),
                              ),
                              onPressed: null,
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: OutlinedButton.icon(
                            icon: Icon(
                              Icons.star,
                              color: Colors.yellow[200],
                            ),
                            label: Text(movie.voteAverage),
                            onPressed: null,
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        Movies().getGender(movie.gender),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (widgets != null)
                      Column(
                        children: [Divider(), ...widgets],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
