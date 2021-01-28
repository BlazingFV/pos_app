// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

class User {
    User({
        this.user,
    });

    UserClass user;

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        user: UserClass.fromMap(json["user"]),
    );

    Map<String, dynamic> toMap() => {
        "user": user.toMap(),
    };
}

class UserClass {
    UserClass({
        this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.phones,
    });

    int id;
    String name;
    String email;
    dynamic emailVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;
    List<Phone> phones;

    factory UserClass.fromJson(String str) => UserClass.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserClass.fromMap( json) => UserClass(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        phones: List<Phone>.from(json["phones"].map((x) => Phone.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "phones": List<dynamic>.from(phones.map((x) => x.toMap())),
    };
}

class Phone {
    Phone({
        this.phone,
        this.id,
    });

    String phone;
    int id;

    factory Phone.fromJson(String str) => Phone.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Phone.fromMap(Map<String, dynamic> json) => Phone(
        phone: json["phone"],
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "phone": phone,
        "id": id,
    };
}
