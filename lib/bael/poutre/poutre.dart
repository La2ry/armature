import 'dart:math';
import '../acier/acier.dart';
import '../barre/barre.dart';
import '../beton/beton.dart';
import '../section/sectionrectangulaire.dart';

class Poutre extends Barre {
  late final Acier acier;
  late final Beton beton;
  late final int temps;
  late final SectionRectangulaire sectionRect;
  Poutre(
      {required super.section,
      required this.sectionRect,
      required super.longueur,
      required super.fissure,
      this.temps = 25,
      super.forceMoment,
      required this.acier,
      required this.beton});

  double dichotomie({required List<double> interv, required Function f}) {
    for (int i = 0; i <= 1000; i++) {
      double m = (interv[0] + interv[1]) / 2;
      if (f(m) * f(interv[0]) < 0) {
        interv[1] = m;
      } else {
        interv[0] = m;
      }
    }
    return (interv[0] + interv[1]) / 2;
  }

  Map<String, double> sectionAcierELU() {
    late double teta;
    if (temps < 1) {
      teta = 0.85;
    } else if (temps >= 1 && temps <= 24) {
      teta = 0.90;
    } else {
      teta = 1.00;
    }
    late final double fbu = 0.85 * beton.resCompression() / (teta * 1.50);
    late final double fsu = acier.resTraction() / 1.15;
    late final double alphaL = 7.0 /
        (7.0 + 2 * (acier.resTraction() * 1000 / (1.15 * acier.moduleLong)));
    late final double muL = 0.80 * alphaL * (1 - 0.40 * alphaL);
    late final double mu = 1000 *
        forceMoment /
        (sectionRect.largeur * pow(0.90 * sectionRect.hauteur, 2) * fbu);
    if (mu >= (5 * muL / 3)) {
      return {'erreur': -404};
    } else {
      if (mu < muL) {
        double beta = 0.8 * 1.25 * (1 - sqrt(1 - 2 * mu));
        return {
          'Ast': beta *
              sectionRect.largeur *
              sectionRect.hauteur *
              0.9 *
              fbu /
              fsu,
          'Asc': 0.0
        };
      } else {
        double d = 0.11 * 0.90 * sectionRect.hauteur;
        double asc = (mu - muL) *
            sectionRect.largeur *
            pow(0.9 * sectionRect.hauteur, 2) *
            fbu /
            ((0.9 * sectionRect.hauteur - d) * fsu);
        return {
          'Asc': asc,
          'Ast': asc +
              0.8 *
                  alphaL *
                  sectionRect.largeur *
                  0.9 *
                  sectionRect.hauteur *
                  fbu /
                  fsu
        };
      }
    }
  }

  Map<String, double> sectionAcierELS() {
    late final double neta = acier.type == TypeAcier.rondLisse ? 1 : 1.6;
    late final double sigmast;
    late final sigmabc = 0.6 * beton.resCompression();
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
    const double delta = 0.11;
    late final double muSer = 1000 *
        forceMoment /
        (sectionRect.largeur * pow(0.90 * sectionRect.hauteur, 2) * sigmast);
    late final double alphaS = 15 * sigmabc / (15 * sigmabc + sigmast);
    late final double muS =
        pow(alphaS, 2) * (1 - alphaS / 3) / (30 * (1 - alphaS));
    if (muSer <= muS) {
      f(x) => pow(x, 3) - 30 * pow(x, 2) - 90 * muSer * x + 90 * muSer;
      double alpha = dichotomie(interv: [0, 1], f: f);
      return {
        'Asc': 0,
        'Ast': pow(alpha, 2) *
            sectionRect.largeur *
            0.9 *
            sectionRect.hauteur /
            (30 * (1 - alpha))
      };
    } else {
      double asc = (muSer - muS) *
          (1 - alphaS) *
          sectionRect.largeur *
          0.90 *
          sectionRect.hauteur /
          ((alphaS - delta) * (1 - delta));
      return {
        'Asc': asc,
        'Ast':
            (30 * (1 - alphaS) * (muSer - muS) + pow(alphaS, 2) * (1 - delta)) *
                sectionRect.largeur *
                0.9 *
                sectionRect.hauteur /
                (30 * (1 - alphaS) * (1 - delta))
      };
    }
  }

  String verificationELS({required double asc, required double ast}) {
    late final double neta = acier.type == TypeAcier.rondLisse ? 1 : 1.6;
    late final double sigmast;
    late final double sigmabc = 0.6 * beton.resCompression();
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
    late final double b = sectionRect.largeur;
    late final double h = sectionRect.hauteur;
    late final double d = 0.90 * h;
    late final double dprim = 0.11 * d;
    f(y) => b * pow(y, 2) + 30 * (ast + asc) * y - 30 * (ast * d + asc * dprim);
    late final double y = dichotomie(interv: [0, h / 2], f: f);
    late final double inertie = b * pow(y, 3) / 3 +
        15 * asc * pow(y - dprim, 2) +
        15 * ast * pow(y - d, 2);

    late final double k = forceMoment / inertie;
    late final double sigmabcMax = 1000 * k * y;
    late final double sigmastMax = 1000 * 15 * k * (d - y);
    late final double sigmascMax = 1000 * 15 * k * (y - dprim);
    if (sigmabcMax < sigmabc && sigmastMax < sigmast && sigmascMax < sigmast) {
      return 'ELS verifiée';
    } else {
      return 'dimentionnement ELS';
    }
  }

  double sectionAcierMin() {
    return max(
        sectionRect.largeur * sectionRect.hauteur / 1000,
        0.23 *
            sectionRect.largeur *
            0.9 *
            sectionRect.hauteur *
            beton.resLimiTraction /
            acier.resLimiTraction);
  }
}
