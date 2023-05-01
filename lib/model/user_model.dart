class UserModel {
  String? userId;
  String? email;
  String? firstName;
  String? lastName;

  UserModel({this.userId, this.email, this.firstName, this.lastName});

  // Receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      userId: map['userId'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
    );
  }

  // Sending data to server
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
