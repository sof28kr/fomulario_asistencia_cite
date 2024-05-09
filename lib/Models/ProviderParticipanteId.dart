import 'package:flutter/material.dart';

class providerParticipanteId extends ChangeNotifier {
  int provParticipanteId;

  providerParticipanteId({this.provParticipanteId = 0});

  void changeProvParticipanteId({
    required int newprovParticipanteId,
  }) async {
    provParticipanteId = newprovParticipanteId;
    notifyListeners();
  }
}
