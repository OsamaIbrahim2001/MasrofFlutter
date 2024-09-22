import 'package:flutter/material.dart';
import 'package:my_project/Providers/masrof_provider.dart';
import 'package:provider/provider.dart';
import 'EditPage.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  String? _selectedOperationType;
  String? _selectedPaymentType;
  String? _selectedReason;
  double? _selectedValue;
  DateTime? _selectedDate;
// Function to display filter dialog

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Masrof Entries'),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                _showFilterDialog(context); // Show filter dialog
              },
            ),
          ],
        ),
        body: Consumer<MasrofProvider>(
          builder: (context, masrofProvider, child) {
            masrofProvider.fetchMasrofList();
            if (masrofProvider.masrofList.isEmpty) {
              return const Center(child: Text('No entries found.'));
            }

            return ListView.builder(
              itemCount: masrofProvider.masrofList.length,
              itemBuilder: (context, index) {
                final masrof = masrofProvider.masrofList[index];
                return Card(
                  child: ListTile(
                    title: Text(
                        '${masrof.operationType} - ${masrof.paymentType} - EGP${masrof.value}'),
                    subtitle: Text(masrof.reason),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        EditMasrofPage(masrof: masrof)));
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            masrofProvider.deleteMasrof(masrof.id!);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

// Function to display filter dialog
  void _showFilterDialog(BuildContext context) {
    final masrofProvider = Provider.of<MasrofProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Filter by:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 16),
              // Filter by Operation Type
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Operation Type'),
                items: ['Send', 'Receive'].map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  masrofProvider.setOperationTypeFilter(value);
                },
              ),
              const SizedBox(height: 16),
              // Filter by Payment Type
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Payment Type'),
                items: ['Wallet', 'Cash', 'Insta'].map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  masrofProvider.setPaymentTypeFilter(value);
                },
              ),
              const SizedBox(height: 16),
              // Filter by Reason
              TextFormField(
                decoration: const InputDecoration(labelText: 'Reason'),
                onChanged: (value) {
                  masrofProvider.setReasonFilter(value);
                },
              ),
              const SizedBox(height: 16),
              // Filter by Value
              TextFormField(
                decoration: const InputDecoration(labelText: 'Value'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  masrofProvider.setValueFilter(double.tryParse(value));
                },
              ),
              const SizedBox(height: 16),
              // Filter by Date
              ElevatedButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    masrofProvider.setOperationDateFilter(selectedDate);
                  }
                },
                child: const Text('Select Date'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Close the modal after filters are applied
                  Navigator.pop(context);
                },
                child: const Text('Apply Filters'),
              ),
            ],
          ),
        );
      },
    );
  }
}
