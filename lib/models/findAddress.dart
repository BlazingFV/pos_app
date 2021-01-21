// To parse this JSON data, do
//
//     final findAddress = findAddressFromMap(jsonString);

import 'dart:convert';

class FindAddress {
    FindAddress({
        this.id,
        this.buildingNo,
        this.rowNo,
        this.flatNo,
        this.street,
        this.remark,
        this.main,
        this.areaNo,
        this.accSerial,
        this.phSerial,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String buildingNo;
    String rowNo;
    String flatNo;
    String street;
    dynamic remark;
    int main;
    int areaNo;
    int accSerial;
    int phSerial;
    DateTime createdAt;
    DateTime updatedAt;

    factory FindAddress.fromJson(String str) => FindAddress.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FindAddress.fromMap(Map<String, dynamic> json) => FindAddress(
        id: json["id"],
        buildingNo: json["BuildingNo"],
        rowNo: json["RowNo"],
        flatNo: json["FlatNo"],
        street: json["Street"],
        remark: json["Remark"],
        main: json["Main"],
        areaNo: json["AreaNo"],
        accSerial: json["AccSerial"],
        phSerial: json["PhSerial"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "BuildingNo": buildingNo,
        "RowNo": rowNo,
        "FlatNo": flatNo,
        "Street": street,
        "Remark": remark,
        "Main": main,
        "AreaNo": areaNo,
        "AccSerial": accSerial,
        "PhSerial": phSerial,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
