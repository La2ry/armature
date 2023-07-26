import 'dart:math';
import 'package:armature/bael/section/sectionrectangulaire.dart';
import '../acier/acier.dart';
import '../sol/sol.dart';

enum EtatLimit { els, elu }

class Semelle {
  late final Sol sol;
  late final double forceCompression;
  late final Acier acier;
  late final EtatLimit etatLimit;
  late final SectionRectangulaire poteau;

  Semelle(
      {required this.acier,
      required this.etatLimit,
      required this.forceCompression,
      required this.poteau,
      required this.sol});

  Map<String, double> section() {
    double q = 0;
    switch (etatLimit) {
      case EtatLimit.els:
        q = sol.qser;
        break;
      case EtatLimit.elu:
        q = sol.qulm;
        break;
    }
    var section = 10 * forceCompression / q;
    var a = sqrt(poteau.largeur * section / poteau.hauteur);
    var b = sqrt(poteau.hauteur * section / poteau.largeur);
    return {'A': a, 'B': b};
  }

  Map<String, double> hauteurUtile() {
    var sectionSemelle = section();
    double dinf = max((sectionSemelle['A']! - poteau.largeur) / 4,
        (sectionSemelle['B']! - poteau.hauteur) / 4);
    double dsup = min(sectionSemelle['A']! - poteau.largeur,
        sectionSemelle['B']! - poteau.hauteur);

    return {'inf': dinf, 'sup': dsup};
  }
}
