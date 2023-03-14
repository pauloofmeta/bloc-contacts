part of 'contact_bloc.dart';

class ContactState extends Equatable {
  final List<Contact> contacts;
  final dynamic error;
  final bool loading;

  const ContactState({
    this.contacts = const [],
    this.error = '',
    this.loading = false,
  });

  ContactState copyWith({
    List<Contact>? contacts,
    dynamic error,
    bool? loading,
  }) {
    return ContactState(
      contacts: contacts ?? this.contacts,
      error: error ?? this.error,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object> get props => [contacts, error, loading];
}

// class ContactListState extends ContactState {
//   final List<Contact> data;

//   ContactListState(this.data);
// }

// class ContactLoadingState extends ContactState {}

// class ContactErrorState extends ContactState {
//   final dynamic error;

//   ContactErrorState(this.error);
// }
