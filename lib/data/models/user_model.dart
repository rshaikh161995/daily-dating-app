class UserModel {
  final String firstName;
  final String lastName;
  final String image;
  final int age;
  final String gender;
  final String city;
  final String state;
  final String country;

  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.age,
    required this.gender,
    required this.city,
    required this.state,
    required this.country,
  });

  factory UserModel.fromJson(
      Map<String, dynamic> json,
      ) {
    final name =
    Map<String, dynamic>.from(
      json['name'] ?? {},
    );

    final dob =
    Map<String, dynamic>.from(
      json['dob'] ?? {},
    );

    final location =
    Map<String, dynamic>.from(
      json['location'] ?? {},
    );

    final picture =
    Map<String, dynamic>.from(
      json['picture'] ?? {},
    );

    return UserModel(
      firstName:
      name['first']?.toString() ?? '',
      lastName:
      name['last']?.toString() ?? '',
      image:
      picture['large']?.toString() ?? '',
      age:
      int.tryParse(
        dob['age']?.toString() ?? '',
      ) ??
          0,
      gender:
      json['gender']?.toString() ?? '',
      city:
      location['city']?.toString() ?? '',
      state:
      location['state']?.toString() ?? '',
      country:
      location['country']?.toString() ?? '',
    );
  }

  String get fullName =>
      '$firstName $lastName';
}