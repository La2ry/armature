import 'dart:math';

import '../beton/beton.dart';
import '../acier/acier.dart';

class Adherence {
  late final Beton beton;
  late final Acier acier;

  Adherence({required this.beton, required this.acier});

  double contraintAdherence() => acier.type == TypeAcier.hauteAdherence
      ? 0.6 * pow(1.50, 2) * beton.resLimiTraction
      : 0.6 * beton.resLimiTraction;

  double longueurScellement() =>
      acier.diametre * acier.resLimiTraction / (4 * contraintAdherence());

  double longueurRecouvrement() => 0.6 * longueurScellement();
}
