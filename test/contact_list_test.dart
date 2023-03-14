import 'package:bloc_contacts/models/contact.dart';
import 'package:bloc_contacts/pages/contatcts/bloc/contact_bloc.dart';
import 'package:bloc_contacts/pages/widgets/contact_list.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ContactBlockMock extends MockBloc<ContactEvent, ContactState>
    implements ContactBloc {}

void main() {
  late ContactBloc bloc;
  late Contact contact;

  setUp(() {
    bloc = ContactBlockMock();
    contact = Contact(name: 'Person', phoneNumber: '5599999999');
  });

  createWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => bloc,
          child: const ContactList(),
        ),
      ),
    );
  }

  testWidgets(
    'When contact list is empty '
    'Should be show a Load Button',
    (tester) async {
      when(() => bloc.state).thenReturn(const ContactState());

      await createWidget(tester);

      expect(find.text('Load Contacts'), findsOneWidget);
    },
  );

  testWidgets(
    'When contact list is not empty '
    'Should be show listview of contacts',
    (tester) async {
      when(() => bloc.state)
          .thenReturn(ContactState(contacts: [contact, contact]));

      bloc.add(ContactFetchEvent());
      await createWidget(tester);

      await tester.pump();

      expect(find.byType(Scrollable), findsOneWidget);
    },
  );
}
