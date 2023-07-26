import 'dart:math';

import '../section/section.dart';

class SectionCirculaire extends Section {
  late double diametre;
  SectionCirculaire({required super.type, required this.diametre});

  @override
  double aire() => pi * pow(diametre, 2) / 4;

  @override
  double momentInertieMax() => pi * pow(diametre, 4) / 64;

  @override
  double momentInertieMin() => momentInertieMax();

  @override
  double rayonGirationMax() => sqrt(momentInertieMax() / aire());

  @override
  double rayonGirationMin() => sqrt(momentInertieMin() / aire());

  @override
  double aireReduit() => pi * pow(diametre - 2, 2) / 4;

  @override
  double perimetre() => pi * diametre;
}
