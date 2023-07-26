import 'dart:math';

import '../section/section.dart';

class SectionRectangulaire extends Section {
  late double largeur, hauteur;
  SectionRectangulaire(
      {required super.type, required this.largeur, required this.hauteur});

  @override
  double aire() => largeur * hauteur;

  @override
  double momentInertieMax() => hauteur >= largeur
      ? largeur * pow(hauteur, 3) / 12
      : hauteur * pow(largeur, 3) / 12;

  @override
  double momentInertieMin() => hauteur <= largeur
      ? largeur * pow(hauteur, 3) / 12
      : hauteur * pow(largeur, 3) / 12;

  @override
  double rayonGirationMax() => sqrt(momentInertieMax() / aire());

  @override
  double rayonGirationMin() => sqrt(momentInertieMin() / aire());
  @override
  double aireReduit() => (largeur - 2) * (hauteur - 2);

  @override
  double perimetre() => 2 * (largeur + hauteur);
}
