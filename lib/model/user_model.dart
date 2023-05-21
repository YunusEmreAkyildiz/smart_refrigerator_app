// class UserModel {
//   String? userId;
//   String? email;
//   String? firstName;
//   String? lastName;

//   UserModel({this.userId, this.email, this.firstName, this.lastName});

//   // Receiving data from server
//   factory UserModel.fromMap(map) {
//     return UserModel(
//       userId: map['userId'],
//       email: map['email'],
//       firstName: map['firstName'],
//       lastName: map['lastName'],
//     );
//   }

//   // Sending data to server
//   Map<String, dynamic> toMap() {
//     return {
//       'userId': userId,
//       'email': email,
//       'firstName': firstName,
//       'lastName': lastName,
//     };
//   }
// }

//

class UserModel {
  String? userId;
  String? email;
  String? firstName;
  String? lastName;
  List<String>? food;

  UserModel({
    this.userId,
    this.email,
    this.firstName,
    this.lastName,
    this.food,
  });

  // factory UserModel.fromMap(map) {
  //   return UserModel(
  //     userId: map['userId'],
  //     email: map['email'],
  //     firstName: map['firstName'],
  //     lastName: map['lastName'],
  //     food: map['food'] != null ? List<String>.from(map['food']) : null,
  //   );
  // }

  factory UserModel.fromMap(Map<String, dynamic>? map) {
    final food = map?['food'];
    List<String>? foodList;

    if (food is List<dynamic>) {
      foodList = food.cast<String>();
    } else if (food is String) {
      foodList = [food];
    }

    return UserModel(
      userId: map?['userId'],
      email: map?['email'],
      firstName: map?['firstName'],
      lastName: map?['lastName'],
      food: foodList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'food': food,
    };
  }
}

  // UserModel copyWith({
  //   String? userId,
  //   String? email,
  //   String? firstName,
  //   String? lastName,
  //   List<String>? food,
  // }) {
  //   return UserModel(
  //     userId: userId ?? this.userId,
  //     email: email ?? this.email,
  //     firstName: firstName ?? this.firstName,
  //     lastName: lastName ?? this.lastName,
  //   );
  // }

  // ...
//}
