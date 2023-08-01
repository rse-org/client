import 'package:flutter/material.dart';

Map formData = {
  'firstName': false,
  'lastName': false,
  'employer': false,
  'age': false,
};

class CustomForm extends StatefulWidget {
  const CustomForm({super.key});

  @override
  State<CustomForm> createState() => _FormState();
}

class _FormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Column(
          children: [
            TextFormField(
              initialValue: '',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                hintText: 'Charles',
                labelText: 'First Name(Icon Left)',
                prefixIcon: Icon(Icons.edit),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              validator: (v) {
                if (v == null || v.isEmpty || v != 'Charles') {
                  formData['firstName'] = false;
                  return 'First name must be "Charles"';
                }
                formData['firstName'] = true;
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: '',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: 'Last Name(Icon Right)',
                hintText: 'Lee',
                suffixIcon: Icon(
                  Icons.error,
                ),
              ),
              validator: (v) {
                formData['lastName'] = true;
                if (v == null || v.isEmpty || v != 'Lee') {
                  formData['lastName'] = false;
                  return 'Last name must be "Lee"';
                }
                formData['lastName'] = true;
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: '',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                hintText: 'CoderSchool',
                labelText: 'Employer(Outline Icon Left)',
                prefixIcon: Icon(Icons.edit),
                border: OutlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              validator: (v) {
                if (v == null || v.isEmpty || v != 'CoderSchool') {
                  formData['employer'] = false;
                  return 'Employer must be "CoderSchool"';
                }
                formData['employer'] = true;
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: '',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                hintText: '18',
                labelText: 'Age(Outline Icon Right)',
                suffixIcon: Icon(
                  Icons.error,
                ),
                border: OutlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              validator: (v) {
                if (v == null || v.isEmpty || v != '18') {
                  formData['age'] = false;
                  return 'Age must be "18"';
                }
                formData['age'] = true;
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Submitting')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
