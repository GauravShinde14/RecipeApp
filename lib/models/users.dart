class User {
  int id;
  String? username;
  String? email;
  String? firstname;
  String? lastname;
  String? gender;
  String? image;
  String? accessToken;
  String? refreshToken;

  User({
    required this.id,
    this.username,
    this.email,
    this.firstname,
    this.lastname,
    this.gender,
    this.image,
    this.accessToken,
    this.refreshToken,
  });

  // copyWith method to create a new instance with modified values
  User copyWith({
    int? id,
    String? username,
    String? email,
    String? firstname,
    String? lastname,
    String? gender,
    String? image,
    String? accessToken,
    String? refreshToken,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  // Factory method to create a User from a map (e.g., from JSON)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0, // Provide default value for non-nullable id
      username: json['username'], // String? allows null values
      email: json['email'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      gender: json['gender'],
      image: json['image'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  // Method to convert User instance to a map (useful for converting to JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'gender': gender,
      'image': image,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
