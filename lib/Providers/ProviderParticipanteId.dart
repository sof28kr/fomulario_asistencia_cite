import 'package:flutter/material.dart';

class providerParticipanteId extends ChangeNotifier {
  int provParticipanteId;
  int provDNIid;
  String provnombreid;
  String provdireccionid;
  int provtelefonoid;
  String provcorreoid;
  int provrucid;
  String provfirmaid;

  providerParticipanteId(
      {this.provParticipanteId = 0,
      this.provDNIid = 0,
      this.provnombreid = "no hay nombre registrado",
      this.provdireccionid = "no hay direccion regitrada",
      this.provtelefonoid = 0,
      this.provcorreoid = "no hay correo registrado",
      this.provrucid = 0,
      this.provfirmaid = "no hay firma registrada"});

  void changeProvParticipanteId({
    required int newprovParticipanteId,
    required int newprovDNIid,
    required String newprovnombreid,
    required String newprovdireccionid,
    required int newprovtelefonoid,
    required String newprovcorreoid,
    required int newprovrucid,
    required String newprovfirmaid,
  }) async {
    provParticipanteId = newprovParticipanteId;
    provDNIid = newprovDNIid;
    provnombreid = newprovnombreid;
    provdireccionid = newprovdireccionid;
    provtelefonoid = newprovtelefonoid;
    provcorreoid = newprovcorreoid;
    provrucid = newprovrucid;
    provfirmaid = newprovfirmaid;
    notifyListeners();
  }
}
