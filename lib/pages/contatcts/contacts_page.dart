import 'package:bloc_contacts/pages/contatcts/bloc/contact_bloc.dart';
import 'package:bloc_contacts/pages/widgets/contact_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
      ),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (ctx, state) {
          if (state.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.error != null && state.error != '') {
            return Container(
              decoration: BoxDecoration(color: Colors.red),
            );
          }

          return const ContactList();
        },
      ),
    );
  }
}
