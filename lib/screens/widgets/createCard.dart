import 'package:flutter/material.dart';

import 'package:themoviedb/class/Movies.dart';
import 'package:themoviedb/helpers/bordered_text.dart';

Widget createCard(Movies movie) => Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      // color: Colors.yellowAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                15.0,
                0.0,
                15.0,
                20.0,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Image.network(
                  movie.picture,
                  alignment: Alignment.center,
                  // width: 80.0,
                  cacheHeight: 200,
                ),
              ),
            ),
            flex: 3,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      movie.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                    // Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: BorderedText(
                        strokeWidth: 3.0,
                        strokeColor: Colors.black,
                        child: Text(
                          movie.voteAverage,
                          style: TextStyle(
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: movie.gender
                //       .map((gender) => SizedBox(
                //             child: Text(gender.toString()),
                //             width: 50.0,
                //           ))
                //       .toList(),
                // ),
              ],
            ),
            // subtitle: Text(movie.description),
            flex: 7,
          ),
        ],
      ),
    );
