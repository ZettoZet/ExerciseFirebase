import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasepaml/model/contact_model.dart';


class ContactController{
  final contactCollection = FirebaseFirestore.instance.collection('contacts');

  final StreamController<List<DocumentSnapshot>> streamController = 
  StreamController<List<DocumentSnapshot>>.broadcast();

  Stream<List<DocumentSnapshot>> get stream => streamController.stream;

  Future addContact(ContactModel ctmodel) async{

    final contact = ctmodel.toMap();
    final DocumentReference docRef = await contactCollection.add(contact);
    final String docId = docRef.id;
    final ContactModel contactModel = ContactModel(id: docId,
    name: ctmodel.name,
    phone: ctmodel.phone,
    email: ctmodel.email,
    address: ctmodel.address);

    await docRef.update(contactModel.toMap());
  }

  Future getContact() async{
    final contact = await contactCollection.get();

    streamController.sink.add(contact.docs);
    return contact.docs;
  }

    Future<void> deleteContact(String id) async {
    await contactCollection.doc(id).delete();
  }

    Future<void> updateContact(ContactModel ctmodel) async {
    final contact = ctmodel.toMap();
    await contactCollection.doc(ctmodel.id).update(contact);
  }

  Future updateContact2(String docId, ContactModel contactModel) async{

    final ContactModel updatedContactModel = ContactModel(
      id: docId,
      name: contactModel.name,
      email: contactModel.email,
      phone: contactModel.phone,
      address: contactModel.address,
      );

      final DocumentSnapshot documentSnapshot =
          await contactCollection.doc(docId).get();
          if (!documentSnapshot.exists) {
            print('Document with ID $docId does not exist');
            return;
          }
          final updatedContact = updatedContactModel.toMap();
          await contactCollection.doc(docId).update(updatedContact);
          await getContact();
          print('Updated contact with ID $docId');
  }
}