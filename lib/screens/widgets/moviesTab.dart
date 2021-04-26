import 'package:flutter/material.dart';
import 'package:themoviedb/screens/widgets/getMovies.dart';

class MoviesTab extends StatefulWidget {
  @override
  _MoviesTabState createState() => _MoviesTabState();
}

class _MoviesTabState extends State<MoviesTab> {
  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    var pageController = PageController(
      initialPage: tabIndex,
      keepPage: false,
    );
    return Column(
      children: [
        SizedBox(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 5,
                child: DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.yellow,
                        width: 5.0,
                        style: tabIndex == 0
                            ? BorderStyle.solid
                            : BorderStyle.none,
                      ),
                    ),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          tabIndex == 0 ? Colors.white : Colors.grey[200],
                    ),
                    onPressed: () {
                      setState(() {
                        tabIndex = 0;
                        pageController.animateToPage(
                          0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      });
                    },
                    child: Text(
                      'Populares',
                      style: _textStyleLabels,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.yellow,
                        width: 5.0,
                        style: tabIndex == 1
                            ? BorderStyle.solid
                            : BorderStyle.none,
                      ),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        tabIndex = 1;
                        pageController.animateToPage(
                          1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor:
                          tabIndex == 1 ? Colors.white : Colors.grey[200],
                    ),
                    child: Text(
                      'Mejor Puntuadas',
                      style: _textStyleLabels,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: PageView(
            onPageChanged: (index) => setState(() {
              tabIndex = index;
            }),
            physics: BouncingScrollPhysics(),
            controller: pageController,
            children: [
              getMoviesPage('movie/popular'),
              getMoviesPage('movie/top_rated'),
            ],
          ),
        ),
      ],
    );
  }

  TextStyle _textStyleLabels = TextStyle(
    fontWeight: FontWeight.w900,
    color: Colors.black,
    fontStyle: FontStyle.italic,
    fontSize: 20.0,
  );
}
