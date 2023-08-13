import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:rse/all.dart';

class AccountForm extends StatefulWidget {
  const AccountForm({super.key});

  @override
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  Account formData = Account();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: inputField(
                context.l.first_name,
                Icons.person,
                'Charles',
                formData.firstName,
                (v) => formData.firstName = v,
              ),
            ),
            Expanded(
              child: inputField(
                context.l.last_name,
                Icons.group,
                'Lee',
                formData.lastName,
                (v) => formData.lastName = v,
              ),
            ),
          ],
        ),
        inputField(
          context.l.email,
          Icons.email,
          'charles@school.com',
          formData.email,
          (v) => formData.email = v,
        ),
        inputField(
          context.l.phone_number,
          Icons.phone,
          '123-456-7890',
          formData.phoneNumber,
          (v) => formData.phoneNumber = v,
        ),
        inputField(
          context.l.address,
          Icons.home,
          '1234 Main St',
          formData.address,
          (v) => formData.address = v,
        ),
        inputField(
          context.l.city,
          Icons.location_city,
          'New York',
          formData.city,
          (v) => formData.city = v,
        ),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: stateTypeAhead(context),
            ),
            Expanded(
              flex: 3,
              child: inputField(context.l.zip_code, Icons.location_pin, '12345',
                  formData.zipCode, (v) => formData.zipCode = v),
            ),
          ],
        ),
        inputField(
          context.l.country,
          Icons.flag,
          'United States',
          formData.country,
          (v) => formData.country = v,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            submitForm();
          },
          child: Text(context.l.submit),
        ),
      ],
    );
  }

  Widget inputField(label, icon, hint, value, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: TextFormField(
        initialValue: value,
        onChanged: onChanged,
        readOnly: kDebugMode,
        showCursor: kDebugMode,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          prefixIcon: Icon(icon),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        validator: (v) {
          if (v == null || v.isEmpty) {
            return 'Please enter valid input';
          }
          return null;
        },
      ),
    );
  }

  TypeAheadField<Map<String, String>> stateTypeAhead(BuildContext context) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(
          hintText: 'NY',
          labelText: context.l.state,
          prefixIcon: const Icon(Icons.location_pin),
        ),
      ),
      suggestionsCallback: (pattern) async {
        return states
            .where((state) =>
                state['name']!.toLowerCase().contains(pattern.toLowerCase()) ||
                state['abbr']!.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
      },
      onSuggestionSelected: (suggestion) {
        (value) => formData.lastName = suggestion['abbr']!;
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          leading: const Icon(Icons.location_pin),
          title: Text(suggestion['abbr']!),
          subtitle: Text(suggestion['name']!),
        );
      },
    );
  }

  void submitForm() {
    if (kDebugMode) {
      p(formData);
    }
  }
}
