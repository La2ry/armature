import '../acier/acier.dart';
import '../beton/beton.dart';

List<Beton> betons = [
  Beton(
      nomMat: 'Beton15',
      resLimiCompression: 15.0,
      resLimiTraction: 1.5,
      moduleLong: 13334.0,
      moduletrans: 6667.0),
  Beton(
      nomMat: 'Beton20',
      resLimiCompression: 20.0,
      resLimiTraction: 1.8,
      moduleLong: 13334.0,
      moduletrans: 6667.0),
  Beton(
      nomMat: 'Beton25',
      resLimiCompression: 25.0,
      resLimiTraction: 2.1,
      moduleLong: 13334.0,
      moduletrans: 6667.0),
  Beton(
      nomMat: 'Beton30',
      resLimiCompression: 30.0,
      resLimiTraction: 2.4,
      moduleLong: 13334.0,
      moduletrans: 6667.0)
];

List<Acier> aciers = [
  Acier(
      nomMat: 'feE500',
      resLimiCompression: 500.0,
      resLimiTraction: 500.0,
      moduleLong: 200000.00,
      moduletrans: 80000.0,
      type: TypeAcier.hauteAdherence,
      diametre: 8.0),
  Acier(
      nomMat: 'feE400',
      resLimiCompression: 400.0,
      resLimiTraction: 400.0,
      moduleLong: 200000.00,
      moduletrans: 80000.0,
      type: TypeAcier.hauteAdherence,
      diametre: 8.0),
  Acier(
      nomMat: 'feE235',
      resLimiCompression: 235.0,
      resLimiTraction: 235.0,
      moduleLong: 200000.00,
      moduletrans: 80000.0,
      type: TypeAcier.rondLisse,
      diametre: 6.0),
  Acier(
      nomMat: 'feE215',
      resLimiCompression: 215.0,
      resLimiTraction: 215.0,
      moduleLong: 200000.00,
      moduletrans: 80000.0,
      type: TypeAcier.hauteAdherence,
      diametre: 5.5),
];
