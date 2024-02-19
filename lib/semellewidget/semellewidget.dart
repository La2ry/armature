import 'package:armature/bael/section/sectionrectangulaire.dart';
import 'package:armature/projetwidget/dispose.dart';
import 'package:flutter/material.dart';
import '../bael/acier/acier.dart';
import '../bael/gabaritmateriau/materiau.dart';
import '../bael/section/section.dart';
import '../bael/semelle/semelle.dart';
import '../bael/sol/sol.dart';

class SemelleWidget extends StatefulWidget {
  const SemelleWidget({super.key});

  @override
  State<SemelleWidget> createState() => _SemelleWidgetState();
}

class _SemelleWidgetState extends State<SemelleWidget> {
  List<Acier> classeAciers = aciers;
  late Acier acierCourant = classeAciers.first;
  late Sol sol = Sol(qadm: 0.15);
  late SectionRectangulaire section = SectionRectangulaire(
      type: SectionType.poteau, largeur: 0.0, hauteur: 0.0);
  final _mainKey = GlobalKey<FormState>();
  final _key = GlobalKey<FormState>();
  late TextEditingController contrainteAdmissibleSol = TextEditingController();
  late TextEditingController coeficientSecurite = TextEditingController();
  late TextEditingController largeur = TextEditingController();
  late TextEditingController hauteur = TextEditingController();
  late TextEditingController effortCompressionService = TextEditingController();
  late TextEditingController effortCompressionUltime = TextEditingController();
  late String resultats = 'Aucun resultat';
  @override
  Widget build(BuildContext context) => Dispose(
      statutBar:
          const Center(child: Text('copyrigth2024.@philosophe14@hotmail.com')),
      mainContent: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
            vertical: 20.0, horizontal: 25.0),
        child: SingleChildScrollView(
          child: Form(
              key: _mainKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Caracteristiques poteau sur semelle'),
                  const Divider(),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: largeur,
                    validator: (value) {
                      if (value!.isEmpty || double.tryParse(value) == null) {
                        return 'Entrez une largeur au poteau';
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
                        return 'Entrez une hauteur au poteau';
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
                  const Text('Effort norrmal centré sur semelle (kN)'),
                  const Divider(),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: effortCompressionService,
                    validator: (value) {
                      if (value!.isEmpty || double.tryParse(value) == null) {
                        return 'Entrez à Nser effort de service';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Nser (kN)', border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: effortCompressionUltime,
                    validator: (value) {
                      if (value!.isEmpty || double.tryParse(value) == null) {
                        return 'Entrez une valuer à Nulm effort ultime';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Nulm (kN)', border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const Text('Resultat'),
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
        padding: const EdgeInsetsDirectional.symmetric(
            vertical: 20.0, horizontal: 25.0),
        child: SingleChildScrollView(
          child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: contrainteAdmissibleSol,
                    validator: (value) {
                      if (value!.isEmpty || double.tryParse(value) == null) {
                        return 'Entrez une contrainte admissible qadm valide';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'qadm (Mpa)', border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: coeficientSecurite,
                    validator: (value) {
                      if (value!.isEmpty || double.tryParse(value) == null) {
                        return 'Entrez une contrainte admissible qadm valide';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Coef sécurité (s)',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    'qadm :${sol.qadm.toStringAsPrecision(3)} Mpa',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    'qulm :${sol.qulm.toStringAsPrecision(3)} Mpa',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    'qser :${sol.qser.toStringAsPrecision(3)} Mpa',
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
                  'Gs :${acierCourant.moduleTrans} Mpa',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ),
      ),
      sideTree: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: 200.0,
              child: ElevatedButton.icon(
                  icon: const Icon(Icons.calculate),
                  onPressed: () {
                    if (_mainKey.currentState!.validate() &&
                        _key.currentState!.validate()) {
                      section = SectionRectangulaire(
                          type: SectionType.poteau,
                          largeur: double.parse(largeur.text),
                          hauteur: double.parse(hauteur.text));

                      setState(() {
                        sol = Sol(
                            qadm: double.parse(contrainteAdmissibleSol.text),
                            s: double.parse(coeficientSecurite.text));
                      });
                      var semelleElu = Semelle(
                          acier: acierCourant,
                          etatLimit: EtatLimit.elu,
                          forceCompression:
                              double.parse(effortCompressionUltime.text),
                          poteau: section,
                          sol: sol);
                      var semelleEls = Semelle(
                          acier: acierCourant,
                          etatLimit: EtatLimit.els,
                          forceCompression:
                              double.parse(effortCompressionService.text),
                          poteau: section,
                          sol: sol);

                      var dimensionSemelleElu = semelleElu.section();
                      var dimensionSemelleEls = semelleEls.section();
                      var hauteurUtileElu = semelleElu.hauteurUtile();
                      var hauteurUtileEls = semelleEls.hauteurUtile();

                      setState(() {
                        resultats =
                            "La semelle doit avoir les dimensions minimales suivantes\n \nELU:: section: A = ${dimensionSemelleElu['A']!.round()} cm, B = ${dimensionSemelleElu['B']!.round()} cm, ${hauteurUtileElu['inf']!.round()} cm <= d <=${hauteurUtileElu['sup']!.round()} cm\n \nELS:: section: A = ${dimensionSemelleEls['A']!.round()} cm, B = ${dimensionSemelleEls['B']!.round()} cm, ${hauteurUtileEls['inf']!.round()} cm <= d <=${hauteurUtileEls['sup']!.round()} cm";
                      });
                    }
                  },
                  label: const Text('calcul'))),
          ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.west),
              label: const Text('retour'))
        ],
      ));
}
