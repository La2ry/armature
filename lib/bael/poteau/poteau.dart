import 'dart:math';
import 'package:armature/bael/barre/barre.dart';
import '../acier/acier.dart';
import '../beton/beton.dart';

class Poteau extends Barre {
  late final double k;
  late final int temps;
  late final Acier acier;
  late final Beton beton;
  late double fbu = beton.resCompression() / 1.5;
  late double fsu = acier.resCompression() / 1.15;
  Poteau(
      {required super.section,
      required super.longueur,
      required this.acier,
      required this.beton,
      required this.k,
      this.temps = 90,
      super.forceCompres,
      super.forceTraction,
      super.forceTranch,
      super.forceMoment});

  double elancement() => k * longueur / section.rayonGirationMin();

  /// alpha est un fonction de l'elancement qui renvoi -1 lorsque l'elancement n'est pas respecter
  double alpha() {
    if (elancement() <= 70) {
      if (elancement() <= 50) {
        if (temps < 28) {
          return 0.85 / (1.0 + 0.20 * pow(elancement() / 35.0, 2)) / 1.20;
        } else if (temps >= 28 && temps < 90) {
          return 0.85 / (1.0 + 0.20 * pow(elancement() / 35.0, 2)) / 1.10;
        } else {
          return 0.85 / (1.0 + 0.20 * pow(elancement() / 35.0, 2));
        }
      } else {
        if (temps < 28) {
          return 0.6 * pow(50 / elancement(), 2) / 1.20;
        } else if (temps >= 28 && temps < 90) {
          return 0.6 * pow(50 / elancement(), 2) / 1.10;
        } else {
          return 0.6 * pow(50 / elancement(), 2);
        }
      }
    } else {
      return -1.0;
    }
  }

  ///retourne la section de l'acier et -1 si la section est faible
  double sectionAcier() => alpha() == -1.0
      ? -1.0
      : (forceCompres / alpha() - section.aireReduit() * 100 * fbu / 0.90) /
          fsu;

  ///retourne la section d'acier minimale
  double sectionAcierMin() {
    double sectionMin1 = 4.0 * section.perimetre();
    double sectionMin2 = 0.002 * section.aire();
    return sectionMin1 >= sectionMin2 ? sectionMin1 : sectionMin2;
  }

  double sectionAcierMax() {
    return 0.05 * section.aire();
  }
}
