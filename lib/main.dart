import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/provider/cacheApp.dart';
import 'package:themoviedb/screens/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider.value(
    return ChangeNotifierProvider<CacheApp>(
      create: (context) => CacheApp(),
      // lazy: false,
      // value: CacheApp(),
      // builder: (context, child) => CacheApp(),

      // MultiProvider(
      //   providers: [
      //     ChangeNotifierProvider.value(
      //       value: CacheApp(),
      //     ),
      //   ],
      child: MaterialApp(
        title: 'Peliculas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.farroTextTheme(),
          primarySwatch: Colors.grey,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
            backgroundColor: Colors.black,
            brightness: Brightness.light,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SafeArea(
          child: Home(),
        ),
      ),
    );
  }
}
