import 'package:bloc_contacts/models/contact.dart';
import 'package:bloc_contacts/pages/contatcts/bloc/contact_bloc.dart';
import 'package:bloc_contacts/repositories/contact_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ContactRepositoryMock extends Mock implements ContactRepository {}

void main() {
  late ContactRepositoryMock repository;
  late ContactBloc bloc;
  late Contact contact;

  setUp(() {
    repository = ContactRepositoryMock();
    bloc = ContactBloc(repository);
    contact = Contact(name: 'Person', phoneNumber: '5599999999');
  });

  tearDown(() {
    bloc.close();
  });

  test('Initial state is correct', () {
    expect(bloc.state.contacts.isEmpty, true);
    expect(bloc.state.loading, false);
  });

  test('Should a contact list', () async {
    final contacts = [contact, contact];
    when(() => repository.getAll()).thenAnswer(
      (_) async => contacts,
    );

    bloc.add(ContactFetchEvent());
    await expectLater(
        bloc.stream,
        emitsInOrder([
          const ContactState(loading: true, contacts: []),
          ContactState(loading: false, contacts: contacts),
        ]));
  });

  test('Should return a erro', () async {
    final exception = Exception('Occurrs a error');
    when(() => repository.getAll()).thenThrow(exception);

    bloc.add(ContactFetchEvent());
    await expectLater(
        bloc.stream,
        emitsInOrder([
          const ContactState(loading: true, contacts: []),
          ContactState(loading: false, error: exception.toString()),
        ]));
  });
}
