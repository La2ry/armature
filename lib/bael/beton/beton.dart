import '../materiaux/materiaux.dart';

class Beton extends Materiau {
  Beton(
      {required super.nomMat,
      required super.resLimiCompression,
      required super.resLimiTraction,
      required super.moduleLong,
      required super.moduletrans,
      super.coefPoisson,
      super.coefSecurite});

  @override
  double get moduleTrans => moduletrans = moduleLong / 2 * (1 + coefPoisson);

  @override
  double resCompression() => resLimiCompression / coefSecurite;

  @override
  double resTraction() => resLimiTraction / coefSecurite;
}
