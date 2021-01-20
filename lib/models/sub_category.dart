// To parse this JSON data, do
//
//     final subCategory = subCategoryFromMap(jsonString);

import 'dart:convert';

SubCategory subCategoryFromMap(String str) => SubCategory.fromMap(json.decode(str));

String subCategoryToMap(SubCategory data) => json.encode(data.toMap());

class SubCategory {
    SubCategory({
        this.id,
        this.groupName,
        this.byWeight,
        this.fatherCode,
        this.active,
        this.createdAt,
        this.updatedAt,
        this.groups,
    });

    int id;
    String groupName;
    int byWeight;
    int fatherCode;
    int active;
    DateTime createdAt;
    DateTime updatedAt;
    List<SubCategory> groups;

    SubCategory copyWith({
        int id,
        String groupName,
        int byWeight,
        int fatherCode,
        int active,
        DateTime createdAt,
        DateTime updatedAt,
        List<SubCategory> groups,
    }) => 
        SubCategory(
            id: id ?? this.id,
            groupName: groupName ?? this.groupName,
            byWeight: byWeight ?? this.byWeight,
            fatherCode: fatherCode ?? this.fatherCode,
            active: active ?? this.active,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            groups: groups ?? this.groups,
        );

    factory SubCategory.fromMap(json) => SubCategory(
        id: json["id"],
        groupName: json["GroupName"],
        byWeight: json["ByWeight"],
        fatherCode: json["FatherCode"] == null ? null : json["FatherCode"],
        active: json["Active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        groups: json["groups"] == null ? null : List<SubCategory>.from(json["groups"].map((x) => SubCategory.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "GroupName": groupName,
        "ByWeight": byWeight,
        "FatherCode": fatherCode == null ? null : fatherCode,
        "Active": active,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "groups": groups == null ? null : List<dynamic>.from(groups.map((x) => x.toMap())),
    };
}
