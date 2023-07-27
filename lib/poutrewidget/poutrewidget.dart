import 'package:armature/bael/acier/acier.dart';
import 'package:armature/bael/section/section.dart';
import 'package:armature/projetwidget/dispose.dart';
import 'package:flutter/material.dart';

import '../bael/barre/barre.dart';
import '../bael/beton/beton.dart';
import '../bael/gabaritmateriau/materiau.dart';
import '../bael/poutre/poutre.dart';
import '../bael/section/sectionrectangulaire.dart';

enum SectionForme { rectangulaire, t }

class PoutreWidget extends StatefulWidget {
  const PoutreWidget({super.key});

  @override
  State<PoutreWidget> createState() => _PoutreWidgetState();
}

class _PoutreWidgetState extends State<PoutreWidget> {
  List<Fissuration> fissures = [
    Fissuration.peuPrejudi,
    Fissuration.prejudis,
    Fissuration.trePrejudis
  ];
  late Fissuration fissure = fissures.first;
  final _key = GlobalKey<FormState>();
  late TextEditingController largeur = TextEditingController();
  late TextEditingController hauteur = TextEditingController();
  late TextEditingController momentSer = TextEditingController();
  late TextEditingController momentUlm = TextEditingController();
  final classeBeton = betons;
  final classeAcier = aciers;
  late Beton betonCourant = classeBeton.first;
  late Acier acierCourant = classeAcier.first;
  late SectionRectangulaire section = SectionRectangulaire(
      type: SectionType.poutre, largeur: 0.0, hauteur: 0.0);
  late String resultats = 'Aucun resultat';
  @override
  void dispose() {
    super.dispose();
    largeur.dispose();
    hauteur.dispose();
    momentSer.dispose();
    momentUlm.dispose();
  }

  @override
  Widget build(BuildContext context) => Dispose(
      statutBar: const Text('Statubar'),
      mainContent: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
        child: SingleChildScrollView(
          child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Caracteristiques de la section poutre'),
                  const Divider(),
                  DropdownButtonFormField(
                    value: fissure,
                    items: fissures
                        .map((fissure) => DropdownMenuItem(
                            value: fissure, child: Text(fissure.name)))
                        .toList(),
                    onChanged: (value) {
                      fissure = value!;
                    },
                    decoration: const InputDecoration(
                        labelText: 'fissuration de la section',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: largeur,
                    validator: (value) {
                      if (value!.isEmpty || double.tryParse(value) == null) {
                        return 'Entrez une valeur à la largeur';
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
                        return 'Entrez une valeur à la hauteur';
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
                  Text(
                    'u :${section.perimetre()} cm2',
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
                  const Text('Effort (My) dans la poutre'),
                  const Divider(),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: momentSer,
                    validator: (value) {
                      if (value!.isEmpty || double.tryParse(value) == null) {
                        return 'Entrez une valeur du moment de service';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Myser (kN.m)',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: momentUlm,
                    validator: (value) {
                      if (value!.isEmpty || double.tryParse(value) == null) {
                        return 'Entrez une valeur du moment ultime';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Myutm (kN.m)',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const Text(
                    'Resultat',
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    resultats,
                    style: const TextStyle(
                        color: Colors.red, fontStyle: FontStyle.italic),
                  )
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
                  items: classeBeton
                      .map((beton) => DropdownMenuItem(
                          value: beton, child: Text(beton.nomMat)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      betonCourant = value!;
                    });
                  },
                  decoration: const InputDecoration(
                      labelText: 'Acier', border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Text('fcj : ${betonCourant.resLimiCompression} Mpa',
                    style: const TextStyle(fontStyle: FontStyle.italic)),
                const SizedBox(
                  height: 25.0,
                ),
                Text('ftj : ${betonCourant.resLimiTraction} Mpa',
                    style: const TextStyle(fontStyle: FontStyle.italic)),
                const SizedBox(
                  height: 25.0,
                ),
                Text('Eb : ${betonCourant.moduleLong} Mpa',
                    style: const TextStyle(fontStyle: FontStyle.italic)),
                const SizedBox(
                  height: 25.0,
                ),
                Text('Gb : ${betonCourant.moduletrans} Mpa',
                    style: const TextStyle(fontStyle: FontStyle.italic)),
              ],
            ),
          ),
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
                items: classeAcier
                    .map((acier) => DropdownMenuItem(
                        value: acier, child: Text(acier.nomMat)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    acierCourant = value!;
                  });
                },
                decoration: const InputDecoration(
                    labelText: 'Acier', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Text('fe : ${acierCourant.resLimiTraction} Mpa',
                  style: const TextStyle(fontStyle: FontStyle.italic)),
              const SizedBox(
                height: 25.0,
              ),
              Text('fec : ${acierCourant.resLimiCompression} Mpa',
                  style: const TextStyle(fontStyle: FontStyle.italic)),
              const SizedBox(
                height: 25.0,
              ),
              Text('Es : ${acierCourant.moduleLong} Mpa',
                  style: const TextStyle(fontStyle: FontStyle.italic)),
              const SizedBox(
                height: 25.0,
              ),
              Text('Gs : ${acierCourant.moduletrans} Mpa',
                  style: const TextStyle(fontStyle: FontStyle.italic)),
            ],
          )),
        ),
      ),
      sideTree: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 200.0,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.calculate),
              label: const Text('calcul'),
              onPressed: () {
                if (_key.currentState!.validate()) {
                  setState(() {
                    section = SectionRectangulaire(
                        type: SectionType.poutre,
                        largeur: double.parse(largeur.text),
                        hauteur: double.parse(hauteur.text));
                  });

                  var poutreELS = Poutre(
                      section: section,
                      sectionRect: section,
                      longueur: 1.0,
                      fissure: fissure,
                      forceMoment: double.parse(momentSer.text),
                      beton: betonCourant,
                      acier: acierCourant);
                  var poutreELU = Poutre(
                      section: section,
                      sectionRect: section,
                      longueur: 1.0,
                      fissure: fissure,
                      forceMoment: double.parse(momentUlm.text),
                      beton: betonCourant,
                      acier: acierCourant);

                  var aSer = poutreELS.sectionAcierELS();
                  var aUlm = poutreELU.sectionAcierELU();
                  var aMin = poutreELU.sectionAcierMin();
                  if (aUlm['erreur'] == -404) {
                    setState(() {
                      resultats =
                          "La section acier de service est A'ser = ${aSer['Asc']!.toStringAsPrecision(3)} cm2 et Aser = ${aSer['Ast']!.toStringAsPrecision(3)} cm2\n \nLa poutre doit etre redimensionné à l'ELU";
                    });
                  } else {
                    var verif = poutreELU.verificationELS(
                        asc: aUlm['Asc']!, ast: aUlm['Ast']!);
                    setState(() {
                      resultats =
                          "$verif \n \nLa section acier de service est A'ser = ${aSer['Asc']!.toStringAsPrecision(3)} cm2 et Aser = ${aSer['Ast']!.toStringAsPrecision(3)} cm2\n \nLa section acier ultime est A'ulm = ${aUlm['Asc']!.toStringAsPrecision(3)} cm2 et Aulm = ${aUlm['Ast']!.toStringAsPrecision(3)} cm2\n \nLa section d'acier minimale Amin = ${aMin.toStringAsPrecision(3)} cm2";
                    });
                  }
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
      ));
}
