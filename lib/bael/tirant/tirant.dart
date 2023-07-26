import 'dart:math';
import '../acier/acier.dart';
import '../barre/barre.dart';
import '../beton/beton.dart';

class Tirant extends Barre {
  late final Acier acier;
  late final Beton beton;
  Tirant(
      {required super.section,
      required super.longueur,
      super.forceTraction,
      required this.beton,
      required this.acier,
      super.fissure});

  double sectionAcierELU() => forceTraction / (acier.resTraction() / 1.15);
  double sectionAcierELS() {
    late final double sigmast;
    late final double neta = acier.type == TypeAcier.rondLisse ? 1 : 1.6;
    switch (fissure) {
      case Fissuration.peuPrejudi:
        sigmast = acier.resTraction();
        break;
      case Fissuration.prejudis:
        sigmast = min(
            2 * acier.resTraction() / 3,
            max(acier.resTraction() / 2,
                110 * sqrt(neta * beton.resTraction())));
      case Fissuration.trePrejudis:
        sigmast =
            min(acier.resTraction() / 2, 90 * sqrt(neta * beton.resTraction()));
    }
    return forceTraction / sigmast;
  }

  double sectionMin() =>
      section.aire() * beton.resTraction() / acier.resTraction();
}
