import 'dart:convert';

import 'package:bloc_contacts/models/contact.dart';
import 'package:http/http.dart';

abstract class ContactRepository {
  Future<List<Contact>> getAll();
}

class ContactRepositoryImpl implements ContactRepository {
  final Client client;

  ContactRepositoryImpl(this.client);

  @override
  Future<List<Contact>> getAll() async {
    final response = await client.get(
      Uri.parse('https://640a804881d8a32198c98f02.mockapi.io/api/contacts'),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro on fetch data');
    }

    final data = jsonDecode(response.body) as List;
    return data.map((e) => Contact.fromMap(e)).toList();
  }
}
