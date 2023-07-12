class UserModel{
  final String name;

  UserModel({required this.name});

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
    };
  }
}