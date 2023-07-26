import '../section/section.dart';

enum Fissuration { peuPrejudi, prejudis, trePrejudis }

abstract class Barre {
  late final Section section;
  late final double longueur;
  late final double forceTraction, forceCompres, forceMoment, forceTranch;
  late final Fissuration fissure;
  Barre(
      {required this.section,
      required this.longueur,
      this.forceTraction = 0,
      this.forceCompres = 0,
      this.forceMoment = 0,
      this.forceTranch = 0,
      this.fissure = Fissuration.peuPrejudi});
}
