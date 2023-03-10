class Contact {
  final String name;
  final String phoneNumber;
  final String? avatar;

  Contact({
    required this.name,
    required this.phoneNumber,
    this.avatar,
  });

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      name: map['name'],
      phoneNumber: map['phone'],
      avatar: map['avatar'],
    );
  }
}
