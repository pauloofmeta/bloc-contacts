import 'package:bloc_contacts/models/contact.dart';
import 'package:bloc_contacts/pages/contatcts/bloc/contact_bloc.dart';
import 'package:bloc_contacts/pages/contatcts/bloc/contact_event.dart';
import 'package:bloc_contacts/pages/contatcts/bloc/contact_state.dart';
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
    expect(bloc.state, isA<ContactLoadingState>());
  });

  test('Should a contact list', () async {
    when(() => repository.getAll()).thenAnswer(
      (_) async => <Contact>[contact, contact],
    );

    bloc.add(FecthContactEvent());
    await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<ContactLoadingState>(),
          isA<ContactListState>(),
        ]));
  });

  test('Should return a erro', () async {
    when(() => repository.getAll()).thenThrow(Exception('Occurrs a error'));

    bloc.add(FecthContactEvent());
    await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<ContactLoadingState>(),
          isA<ContactErrorState>(),
        ]));
  });
}
