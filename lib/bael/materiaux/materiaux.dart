abstract class Materiau {
  late String nomMat;
  late double resLimiCompression, resLimiTraction;
  late double moduleLong, moduletrans;
  late double coefSecurite, coefPoisson;

  Materiau(
      {required this.nomMat,
      required this.resLimiCompression,
      required this.resLimiTraction,
      required this.moduleLong,
      required this.moduletrans,
      this.coefPoisson = 0.0,
      this.coefSecurite = 1.0});

  double resCompression();
  double resTraction();
  double get moduleTrans;
}
