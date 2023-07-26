import '../materiaux/materiaux.dart';

enum TypeAcier { rondLisse, hauteAdherence }

/// Definition de la classe Acier et de ses caracteristiques mecanique
class Acier extends Materiau {
  final TypeAcier type;
  final double diametre;

  ///coonstructeur de l'instance acier fonction des parametres
  Acier(
      {required super.nomMat,
      required super.resLimiCompression,
      required super.resLimiTraction,
      required super.moduleLong,
      required super.moduletrans,
      required this.type,
      required this.diametre,
      super.coefPoisson,
      super.coefSecurite});

  @override
  double resCompression() => resLimiCompression / coefSecurite;

  @override
  double resTraction() => resLimiTraction / coefSecurite;

  @override
  double get moduleTrans => moduletrans = moduleLong / 2 * (1 + coefPoisson);
}
