class UserModel {
  UserModel(
    this.name,
    this.email,
    this.password,
    this.enlist,
    this.unitId,
    this.unitIds,
  );

  final String name;
  final String email;
  final String password;
  final DateTime enlist;
  final String unitId;
  final List<String> unitIds;

  factory UserModel.fromDoc(Map<String, dynamic> doc) => UserModel(
        doc["name"],
        doc["email"],
        doc["password"],
        DateTime.fromMillisecondsSinceEpoch(
          doc["enlist"].seconds * 1000,
        ),
        doc["unit_id"],
        List<String>.from(doc["unit_ids"] as List),
      );
}
