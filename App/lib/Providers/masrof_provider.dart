import 'package:flutter/material.dart';
import 'package:my_project/Database/masrof_database.dart';
import 'package:my_project/Models/MasrofModel.dart';

class MasrofProvider extends ChangeNotifier {
  List<Masrof> _masrofList = [];

  List<Masrof> get masrofList => _masrofList;
// Fields for filtering
  String? _operationTypeFilter;
  String? _paymentTypeFilter;
  String? _reasonFilter;
  double? _valueFilter;
  DateTime? _operationDateFilter;

  // Setters for filters
  void setOperationTypeFilter(String? operationType) {
    _operationTypeFilter = operationType;
    fetchMasrofList();
  }

  void setPaymentTypeFilter(String? paymentType) {
    _paymentTypeFilter = paymentType;
    fetchMasrofList();
  }

  void setReasonFilter(String? reason) {
    _reasonFilter = reason;
    fetchMasrofList();
  }

  void setValueFilter(double? value) {
    _valueFilter = value;
    fetchMasrofList();
  }

  void setOperationDateFilter(DateTime? date) {
    _operationDateFilter = date;
    fetchMasrofList();
  }

  // Fetch all entries
  Future<void> fetchMasrofList() async {
    _masrofList = await MasrofDatabase().getMasrofList(
        operationDateFilter: _operationDateFilter,
        operationTypeFilter: _operationTypeFilter,
        paymentTypeFilter: _paymentTypeFilter,
        valueFilter: _valueFilter,
        reasonFilter: _reasonFilter);
    notifyListeners();
  }

  // Clear filters
  void clearFilters() {
    _operationTypeFilter = null;
    _paymentTypeFilter = null;
    _reasonFilter = null;
    _valueFilter = null;
    _operationDateFilter = null;
    fetchMasrofList();
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
