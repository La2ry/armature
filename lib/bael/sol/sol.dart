class Sol {
  late final double qadm;
  late final double qulm;
  late final double qser;
  late final double s;

  Sol({required this.qadm, this.s = 1})
      : qulm = qadm / s,
        qser = 2 * (qadm / s) / 3;
}
