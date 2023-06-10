import 'package:firebasepaml/controller/contact_controller.dart';
import 'package:firebasepaml/model/contact_model.dart';
import 'package:firebasepaml/view/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddContact extends StatefulWidget {
  AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  var contactController = ContactController();
  final formKey = GlobalKey<FormState>();
  String? name;
  String? phone;
  String? email;
  String? address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
                onChanged: (value) => name = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Phone',
                ),
                onChanged: (value) => phone = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                onChanged: (value) => email = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Address',
                ),
                onChanged: (value) => address = value,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: const Text('Add Contact'),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    ContactModel cm = ContactModel(
                      name: name!, //dari variabel di def. diatas
                      phone: phone!,
                      email: email!,
                      address: address!,
                    );
                    contactController.addContact(cm).then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Contact(),
                        ),
                      );
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Contact Added'),
                        duration: Duration(seconds: 1),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
