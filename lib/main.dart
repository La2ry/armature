import 'package:armature/poteauwidget/poteauwidget.dart';
import 'package:armature/poutrewidget/poutrewidget.dart';
import 'package:armature/semellewidget/semellewidget.dart';
import 'package:armature/tirantwidget/tiranwidget.dart';
import 'package:flutter/material.dart';

import 'projetwidget/carte.dart';

void main(List<String> args) {
  runApp(const MyApp());
  return;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Armature BAEL91 mod 99',
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          brightness: Brightness.light,
          primaryColor: const Color.fromARGB(99, 235, 235, 235)),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SizedBox(
        width: 500,
        height: 400,
        child: GridView.count(
          padding: const EdgeInsets.all(25.0),
          crossAxisCount: 4,
          children: [
            Carte(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Scaffold(body: TiranWidget())));
              },
              child: const Center(child: Text('Traction simple')),
            ),
            Hero(
              transitionOnUserGestures: true,
              tag: 'Poteau',
              child: Carte(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          const Scaffold(body: PoteauWidget())));
                },
                child: const Center(child: Text('Compression')),
              ),
            ),
            Carte(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        const Scaffold(body: PoutreWidget())));
              },
              child: const Center(child: Text('Flexion simple')),
            ),
            Carte(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        const Scaffold(body: SemelleWidget())));
              },
              child: const Center(child: Text('Semelle')),
            ),
            Carte(
              color: Theme.of(context).primaryColor,
              onPressed: () {},
              child: const Center(child: Icon(Icons.help_center_sharp)),
            ),
          ],
        ),
      ),
    ));
  }
}
