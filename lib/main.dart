import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
import 'package:rajaongkir_api/services/services.dart';
import 'package:rajaongkir_api/shared/shared.dart';
import 'package:rajaongkir_api/views/pages/pages.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const OngkirPage(),
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Style.blue500,
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: GoogleFonts.inter().fontFamily,
                bodyColor: Style.white,
                displayColor: Style.white,
              ),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: Style.black,
            foregroundColor: Style.white,
            centerTitle: true,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(Style.blue500),
              foregroundColor: MaterialStateProperty.all<Color>(Style.white),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.all(16),
              ),
            ),
          ),
        ),
        title: 'Raja Ongkir',
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await RajaOngkirService.getOngkir().then((value) {
            var result = json.decode(value.body);
            print(result.toString());
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
