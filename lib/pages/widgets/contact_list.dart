import 'package:bloc_contacts/pages/contatcts/bloc/contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactBloc, ContactState>(
      builder: (ctx, state) {
        final contactList = state.contacts;

        if (contactList.isEmpty) {
          return Center(
            child: TextButton(
              onPressed: () =>
                  context.read<ContactBloc>().add(ContactFetchEvent()),
              child: const Text('Load Contacts'),
            ),
          );
        }

        return ListView.separated(
          itemCount: contactList.length,
          separatorBuilder: (c, i) => const Divider(thickness: 1.0),
          itemBuilder: (c, i) {
            final contact = contactList[i];
            return Card(
              child: ListTile(
                title: Text(contact.name),
                subtitle: Text(contact.phoneNumber),
              ),
            );
          },
        );
      },
    );
  }
}
