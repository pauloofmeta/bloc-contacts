import 'package:bloc_contacts/models/contact.dart';

abstract class ContactState {}

class ContactListState extends ContactState {
  final List<Contact> data;

  ContactListState(this.data);
}

class ContactLoadingState extends ContactState {}

class ContactErrorState extends ContactState {
  final dynamic error;

  ContactErrorState(this.error);
}
