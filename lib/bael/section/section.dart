enum SectionType {
  tirant,
  poteau,
  poutre,
}

abstract class Section {
  late SectionType type;
  Section({required this.type});

  double aire();
  double aireReduit();
  double perimetre();
  double momentInertieMin();
  double momentInertieMax();
  double rayonGirationMax();
  double rayonGirationMin();
}
