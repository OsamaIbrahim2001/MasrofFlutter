import 'package:flutter/material.dart';
import 'package:my_project/Models/MasrofModel.dart';
import 'package:my_project/Providers/masrof_provider.dart';
import 'package:provider/provider.dart';

class EditMasrofPage extends StatefulWidget {
  final Masrof? masrof;

  const EditMasrofPage({super.key, this.masrof});

  @override
  _EditMasrofPageState createState() => _EditMasrofPageState();
}

class _EditMasrofPageState extends State<EditMasrofPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _operationDateController =
      TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  String? _selectedOperationType;
  String? _selectedPaymentType;

  @override
  void initState() {
    super.initState();
    if (widget.masrof != null) {
      _operationDateController.text = widget.masrof!.operationDate;
      _valueController.text = widget.masrof!.value.toString();
      _reasonController.text = widget.masrof!.reason;
      _selectedOperationType = widget.masrof!.operationType;
      _selectedPaymentType = widget.masrof!.paymentType;
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final newMasrof = Masrof(
        id: widget.masrof?.id,
        operationDate: _operationDateController.text,
        value: double.parse(_valueController.text),
        operationType: _selectedOperationType!,
        paymentType: _selectedPaymentType!,
        reason: _reasonController.text,
      );

      if (widget.masrof == null) {
        Provider.of<MasrofProvider>(context, listen: false)
            .addMasrof(newMasrof);
      } else {
        Provider.of<MasrofProvider>(context, listen: false)
            .updateMasrof(newMasrof);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.masrof == null ? 'Create Entry' : 'Edit Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _operationDateController,
                decoration: const InputDecoration(labelText: 'Operation Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _valueController,
                decoration: const InputDecoration(labelText: 'Value'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Please enter a valid value';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Operation Type'),
                value: _selectedOperationType,
                items: ['Send', 'Receive'].map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedOperationType = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Payment Type'),
                value: _selectedPaymentType,
                items: ['Wallet', 'Cash', 'Insta'].map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentType = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _reasonController,
                decoration: const InputDecoration(labelText: 'Reason'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a reason';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
