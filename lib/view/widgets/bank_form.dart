import 'package:flutter/material.dart';
import 'package:rse/all.dart';

class BankAccount {
  String name = '';
  dynamic routingNumber = 0;
  dynamic accountNumber = 0;
}

class BankForm extends StatefulWidget {
  const BankForm({super.key});

  @override
  State<BankForm> createState() => _BankFormState();
}

class _BankFormState extends State<BankForm> {
  BankAccount form = BankAccount();
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
          child: _buildForm(context),
        ),
      ),
      child: const Text('Add Bank Account'),
    );
  }

  Widget inputField(label, icon, hint, value, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: TextFormField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          prefixIcon: Icon(icon),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        validator: (v) {
          return null;
        },
      ),
    );
  }

  _buildForm(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          inputField(
            'Name',
            Icons.email,
            'Bank Of America',
            form.name,
            (v) => form.name = v,
          ),
          inputField(
            'Routing Number',
            Icons.account_balance,
            '0123456',
            form.routingNumber,
            (String v) => form.routingNumber = v,
          ),
          inputField(
            'Account Number',
            Icons.account_balance,
            '88888888',
            form.accountNumber,
            (String v) => form.accountNumber = v,
          ),
          TextButton(
            onPressed: () {
              LocalStorageService.bankAccountsSave(
                  form.name, form.routingNumber, form.accountNumber);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
