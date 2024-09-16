import 'package:flutter/material.dart';
import 'package:my_project/Database/masrof_database.dart';
import 'package:my_project/Models/MasrofModel.dart';

class MasrofProvider extends ChangeNotifier {
  List<Masrof> _masrofList = [];

  List<Masrof> get masrofList => _masrofList;

  // Fetch all entries
  Future<void> fetchMasrofList() async {
    _masrofList = await MasrofDatabase().getMasrofList();
    notifyListeners();
  }

  // Add a new entry
  Future<void> addMasrof(Masrof masrof) async {
    await MasrofDatabase().insertMasrof(masrof);
    await fetchMasrofList();
  }

  // Update an entry
  Future<void> updateMasrof(Masrof masrof) async {
    await MasrofDatabase().updateMasrof(masrof);
    await fetchMasrofList();
  }

  // Delete an entry
  Future<void> deleteMasrof(int id) async {
    await MasrofDatabase().deleteMasrof(id);
    await fetchMasrofList();
  }
}
