import 'package:flutter/material.dart';
import '../bael/acier/acier.dart';
import '../bael/barre/barre.dart';
import '../bael/beton/beton.dart';
import '../bael/section/section.dart';
import '../bael/section/sectioncirculaire.dart';
import '../bael/section/sectionrectangulaire.dart';
import '../bael/tirant/tirant.dart';
import '../projetwidget/dispose.dart';
import '../bael/gabaritmateriau/materiau.dart';

enum SectionForme { rectangulaire, circulaire }

class TiranWidget extends StatefulWidget {
  const TiranWidget({super.key});

  @override
  State<TiranWidget> createState() => _TiranWidgetState();
}

class _TiranWidgetState extends State<TiranWidget> {
  final _key = GlobalKey<FormState>();
  List<Beton> classeBetons = betons;
  List<Acier> classeAcier = aciers;
  Beton betonCourant = betons.first;
  Acier acierCourant = aciers.first;
  late Section section =
      SectionRectangulaire(hauteur: 0, largeur: 0, type: SectionType.tirant);
  late TextEditingController diametre = TextEditingController();
  late TextEditingController largeur = TextEditingController();
  late TextEditingController hauteur = TextEditingController();
  late TextEditingController effortService = TextEditingController();
  late TextEditingController effortUltime = TextEditingController();
  List<SectionForme> formes = [
    SectionForme.rectangulaire,
    SectionForme.circulaire
  ];
  List<Fissuration> fissures = [
    Fissuration.peuPrejudi,
    Fissuration.prejudis,
    Fissuration.trePrejudis
  ];
  late SectionForme formeCourant = formes.first;
  late Fissuration fissure = fissures.first;
  late String resultats = 'Aucun resultat';
  @override
  void dispose() {
    super.dispose();
    diametre.dispose();
    largeur.dispose();
    hauteur.dispose();
  }

  @override
  Widget build(BuildContext context) => Dispose(
        mainContent: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 30.0),
          child: SingleChildScrollView(
            child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25.0,
                    ),
                    const Text("Caracteristiques section"),
                    const Divider(),
                    const SizedBox(
                      height: 25.0,
                    ),
                    DropdownButtonFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Fissuration'),
                        value: fissure,
                        items: fissures
                            .map((fissure) => DropdownMenuItem(
                                value: fissure, child: Text(fissure.name)))
                            .toList(),
                        onChanged: (value) {
                          fissure = value!;
                        }),
                    const SizedBox(
                      height: 25.0,
                    ),
                    DropdownButtonFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Section'),
                        value: formeCourant,
                        items: formes
                            .map((forme) => DropdownMenuItem(
                                value: forme, child: Text(forme.name)))
                            .toList(),
                        onChanged: (value) {
                          formeCourant = value!;
                        }),
                    const SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      controller: diametre,
                      decoration: const InputDecoration(
                          labelText: 'Diametre (cm)',
                          border: OutlineInputBorder()),
                      validator: (diametre) => (diametre!.isEmpty ||
                              double.tryParse(diametre) == null)
                          ? 'Entrez le diametre, si il est null entrez 0'
                          : null,
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      controller: largeur,
                      decoration: const InputDecoration(
                          labelText: 'Largeur (cm)',
                          border: OutlineInputBorder()),
                      validator: (largeur) =>
                          (largeur!.isEmpty || double.tryParse(largeur) == null)
                              ? 'Entrez la largeur '
                              : null,
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      controller: hauteur,
                      decoration: const InputDecoration(
                          labelText: 'Hauteur (cm)',
                          border: OutlineInputBorder()),
                      validator: (hauteur) =>
                          (hauteur!.isEmpty || double.tryParse(hauteur) == null)
                              ? 'Entrez la hauteur '
                              : null,
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
                    const Text("Actions sur le tirant"),
                    const Divider(),
                    const Text("Effort Normal (N)"),
                    const SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      controller: effortService,
                      decoration: const InputDecoration(
                          labelText: 'Nser(kN)', border: OutlineInputBorder()),
                      validator: (value) =>
                          (value!.isEmpty || double.tryParse(value) == null)
                              ? 'Entrez N de service '
                              : null,
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      controller: effortUltime,
                      decoration: const InputDecoration(
                          labelText: 'Nulm (kN)', border: OutlineInputBorder()),
                      validator: (value) =>
                          (value!.isEmpty || double.tryParse(value) == null)
                              ? 'Entrez N ultime '
                              : null,
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    const Text("Resultats"),
                    const Divider(),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Text(resultats, style: const TextStyle(color: Colors.red))
                  ],
                )),
          ),
        ),
        sideOne: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
          child: SingleChildScrollView(
            child: Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField(
                    value: betonCourant,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Classe de béton'),
                    items: betons
                        .map((beton) => DropdownMenuItem(
                            value: beton, child: Text(beton.nomMat)))
                        .toList(),
                    onChanged: (beton) {
                      setState(() {
                        betonCourant = beton!;
                      });
                    }),
                const SizedBox(height: 10.0),
                Text("fcj : ${betonCourant.resLimiCompression} Mpa",
                    style: const TextStyle(fontStyle: FontStyle.italic)),
                const SizedBox(height: 10.0),
                Text("ftj : ${betonCourant.resLimiTraction} Mpa",
                    style: const TextStyle(fontStyle: FontStyle.italic)),
                const SizedBox(height: 10.0),
                Text("Eb : ${betonCourant.moduleLong} Mpa",
                    style: const TextStyle(fontStyle: FontStyle.italic)),
                const SizedBox(height: 10.0),
                Text("Gb : ${betonCourant.moduleTrans} Mpa",
                    style: const TextStyle(fontStyle: FontStyle.italic)),
              ],
            )),
          ),
        ),
        sideTwo: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
          child: SingleChildScrollView(
            child: Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField(
                    value: acierCourant,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Acier principal'),
                    items: aciers
                        .map((acier) => DropdownMenuItem(
                            value: acier, child: Text(acier.nomMat)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        acierCourant = value!;
                      });
                    }),
                const SizedBox(height: 10.0),
                Text(
                  "fe : ${acierCourant.resLimiCompression} Mpa",
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 10.0),
                Text("fe : ${acierCourant.resLimiTraction} Mpa",
                    style: const TextStyle(fontStyle: FontStyle.italic)),
                const SizedBox(height: 10.0),
                Text("Es : ${acierCourant.moduleLong} Mpa",
                    style: const TextStyle(fontStyle: FontStyle.italic)),
                const SizedBox(height: 10.0),
                Text("Gs : ${acierCourant.moduleTrans} Mpa",
                    style: const TextStyle(fontStyle: FontStyle.italic)),
              ],
            )),
          ),
        ),
        sideTree: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.calculate),
                label: const Text('Calcul'),
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    setState(() {
                      if (formeCourant == SectionForme.circulaire) {
                        section = SectionCirculaire(
                            type: SectionType.tirant,
                            diametre: double.parse(diametre.text));
                      } else {
                        section = SectionRectangulaire(
                            type: SectionType.tirant,
                            largeur: double.parse(largeur.text),
                            hauteur: double.parse(hauteur.text));
                      }
                    });

                    var tirantELS = Tirant(
                        section: section,
                        longueur: 1,
                        forceTraction: double.parse(effortService.text),
                        beton: betonCourant,
                        acier: acierCourant,
                        fissure: fissure);
                    var tirantELU = Tirant(
                        section: section,
                        longueur: 1,
                        forceTraction: double.parse(effortUltime.text),
                        beton: betonCourant,
                        acier: acierCourant,
                        fissure: fissure);
                    var aSer = tirantELS.sectionAcierELS() * 10;
                    var aUlm = tirantELU.sectionAcierELU() * 10;
                    var amin = tirantELS.sectionMin();

                    setState(() {
                      resultats =
                          "La section d'acier de service Aser = $aSer cm2 \n \nLa section d'acier ultime Aulm = $aUlm cm2 \n \nLa section d'acier minimale est Amin = $amin cm2";
                    });
                  }
                },
              ),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.west),
                label: const Text('retour'))
          ],
        ),
        statutBar: const Text('statut bar'),
      );
}
