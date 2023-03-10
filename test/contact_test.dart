import 'package:bloc_contacts/models/contact.dart';
import 'package:test/test.dart';

void main() {
  test('Contact is worked', () {
    final contact = Contact(name: 'Person', phoneNumber: '5599999999');
    expect(contact.name, allOf(isA<String>(), equals('Person'), isNotNull));
  }, tags: 'model');
}
