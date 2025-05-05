class User {
  final String id;
  final int bib;
  final String name;

  User({
    required this.id,
    required this.bib,
    required this.name,
  });

  factory User.fromMap(String id, Map<String, dynamic> data) {
    return User(
      id: id,
      bib: data['bib'],
      name: data['name'],
    );
  }
}
