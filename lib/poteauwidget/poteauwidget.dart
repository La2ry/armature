import 'package:armature/bael/section/sectionrectangulaire.dart';
import 'package:armature/projetwidget/dispose.dart';
import 'package:flutter/material.dart';
import '../bael/gabaritmateriau/materiau.dart';
import '../bael/acier/acier.dart';
import '../bael/beton/beton.dart';
import '../bael/poteau/poteau.dart';
import '../bael/section/section.dart';
import '../bael/section/sectioncirculaire.dart';

enum SectionForme { rectangulaire, circulaire }

class PoteauWidget extends StatefulWidget {
  const PoteauWidget({super.key});

  @override
  State<PoteauWidget> createState() => _PoteauWidgetState();
}

class _PoteauWidgetState extends State<PoteauWidget> {
  List<SectionForme> formes = [
    SectionForme.rectangulaire,
    SectionForme.circulaire
  ];
  late SectionForme formeCourant = formes.first;
  final _key = GlobalKey<FormState>();
  late TextEditingController diametre = TextEditingController();
  late TextEditingController largeur = TextEditingController();
  late TextEditingController hauteur = TextEditingController();
  late TextEditingController longueur = TextEditingController();
  late TextEditingController k = TextEditingController();
  late TextEditingController effortCompression = TextEditingController();
  late TextEditingController temps = TextEditingController();
  List<Beton> classeBetons = betons;
  List<Acier> classeAciers = aciers;
  late Beton betonCourant = classeBetons.first;
  late Acier acierCourant = classeAciers.first;
  late Section section =
      SectionRectangulaire(type: SectionType.poteau, largeur: 0, hauteur: 0);
  late String resultats = 'Aucun resulta';
  @override
  Widget build(BuildContext context) => Dispose(
      statutBar: const Text('copyrigth2024.@philosophe14@hotmail.com'),
      mainContent: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
        child: SingleChildScrollView(
          child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Hero(
                      transitionOnUserGestures: true,
                      tag: "Poteau",
                      child: Text('Caracteristiques du Poteau')),
                  const Divider(),
                  const SizedBox(
                    height: 25.0,
                  ),
                  DropdownButtonFormField(
                    value: formeCourant,
                    items: formes
                        .map((forme) => DropdownMenuItem(
                            value: forme, child: Text(forme.name)))
                        .toList(),
                    onChanged: (value) {
                      formeCourant = value!;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Section', border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: diametre,
                    validator: (value) {
                      if (value!.isEmpty || double.tryParse(value) == null) {
                        return 'Entrez une valeur au diametre ou 0 si null';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'diametre (cm)',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: largeur,
                    validator: (value) {
                      if (value!.isEmpty || double.tryParse(value) == null) {
                        return 'Entrez une valeur à la largeur ou 0 si null';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'largeur (cm)',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: hauteur,
                    validator: (value) {
                      if (value!.isEmpty || double.tryParse(value) == null) {
                        return 'Entrez une valeur à la hauteur ou 0 si null';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'hauteur (cm)',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: longueur,
                    validator: (value) {
                      if (value!.isEmpty || double.tryParse(value) == null) {
                        return 'Entrez une valeur à la longueur ou 0 si null';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'longueur (cm)',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: k,
                    validator: (value) {
                      if (value!.isEmpty || double.tryParse(value) == null) {
                        return 'Entrez une valeur à k = lf/lo';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'k=lf/lo', border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    'u :${section.perimetre()} cm',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    'B :${section.aire()} cm2',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    'Br :${section.aireReduit()} cm2',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    'Imin :${section.momentInertieMin()} cm4',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    'Imax :${section.momentInertieMax()} cm4',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    'imin :${section.rayonGirationMin()} cm',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    'imax :${section.rayonGirationMax()} cm',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const Text('Effort Ultime (N) de compression'),
                  const Divider(),
                  TextFormField(
                    controller: effortCompression,
                    validator: (value) {
                      if (value!.isEmpty || double.tryParse(value) == null) {
                        return 'Entrez une valeur de effort de compression axial';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Nu (kN)', border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: temps,
                    validator: (value) {
                      if (value!.isEmpty || double.tryParse(value) == null) {
                        return 'Entrez une valeur au temps application Nu/2';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'temps (jour)',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const Text('Resultat'),
                  const Divider(),
                  Text(resultats,
                      style: const TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.red))
                ],
              )),
        ),
      ),
      sideOne: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
        child: SingleChildScrollView(
          child: Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField(
                value: betonCourant,
                items: betons
                    .map((beton) => DropdownMenuItem(
                        value: beton, child: Text(beton.nomMat)))
                    .toList(),
                onChanged: ((value) {
                  setState(() {
                    betonCourant = value!;
                  });
                }),
                decoration: const InputDecoration(
                    labelText: 'Béton', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 25.0),
              Text(
                'fcj :${betonCourant.resLimiCompression} Mpa',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 25.0),
              Text(
                'ftj :${betonCourant.resLimiTraction} Mpa',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 25.0),
              Text(
                'Eb :${betonCourant.moduleLong} Mpa',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 25.0),
              Text(
                'Gb :${betonCourant.moduleTrans} Mpa',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          )),
        ),
      ),
      sideTwo: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
        child: SingleChildScrollView(
            child: Form(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField(
              value: acierCourant,
              items: classeAciers
                  .map((acier) =>
                      DropdownMenuItem(value: acier, child: Text(acier.nomMat)))
                  .toList(),
              onChanged: ((value) {
                setState(() {
                  acierCourant = value!;
                });
              }),
              decoration: const InputDecoration(
                  labelText: 'Acier', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Text(
              'fe :${acierCourant.resLimiTraction} Mpa',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Text(
              'fec :${acierCourant.resLimiCompression} Mpa',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Text(
              'Es :${acierCourant.moduleLong} Mpa',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Text(
              'Gs :${acierCourant.moduletrans} Mpa',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ))),
      ),
      sideTree: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 200.0,
            child: ElevatedButton.icon(
                icon: const Icon(Icons.calculate),
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    if (formeCourant == SectionForme.circulaire) {
                      setState(() {
                        section = SectionCirculaire(
                            type: SectionType.poteau,
                            diametre: double.parse(diametre.text));
                      });
                    } else {
                      setState(() {
                        section = SectionRectangulaire(
                            type: SectionType.poteau,
                            largeur: double.parse(largeur.text),
                            hauteur: double.parse(hauteur.text));
                      });
                    }

                    var poteau = Poteau(
                        section: section,
                        longueur: double.parse(longueur.text),
                        beton: betonCourant,
                        acier: acierCourant,
                        k: double.parse(k.text),
                        temps: int.parse(temps.text),
                        forceCompres:
                            double.parse(effortCompression.text) * 1000);
                    var aSc = poteau.sectionAcier() / 100;
                    var amin = poteau.sectionAcierMin() / 100;
                    var amax = poteau.sectionAcierMax();
                    var lambda = poteau.elancement();
                    var alpha = poteau.alpha();
                    setState(() {
                      setState(() {
                        resultats =
                            "L'elancement du poteau = $lambda \n \nAlpha poteau ù = $alpha \n \nLa section d'acier théorique Asc = $aSc cm2 \n \nLa section d'acier minimale est Amax = $amax cm2 \n \nLa section d'acier maximale est Amin = $amin cm2";
                      });
                    });
                  }
                },
                label: const Text('calcul')),
          ),
          ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.west),
              label: const Text('retour'))
        ],
      ));
}
