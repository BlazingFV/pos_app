// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

import 'dart:convert';

class Product {
    Product({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    int currentPage;
    List<Datum> data;
    String firstPageUrl;
    int from;
    int lastPage;
    String lastPageUrl;
    dynamic nextPageUrl;
    String path;
    int perPage;
    dynamic prevPageUrl;
    int to;
    int total;

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(json) => Product(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class Datum {
    Datum({
        this.id,
        this.productCode,
        this.itemName,
        this.itemImage,
        this.byWeight,
        this.vat,
        this.postp,
        this.pospp,
        this.minorPerMajor,
        this.activeItem,
        this.inStock,
        this.groupCode,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String productCode;
    String itemName;
    String itemImage;
    int byWeight;
    int vat;
    int postp;
    int pospp;
    int minorPerMajor;
    int activeItem;
    int inStock;
    int groupCode;
    DateTime createdAt;
    DateTime updatedAt;

    factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productCode: json["ProductCode"],
        itemName: json["ItemName"],
        itemImage: json["ItemImage"],
        byWeight: json["ByWeight"],
        vat: json["vat"],
        postp: json["POSTP"],
        pospp: json["POSPP"],
        minorPerMajor: json["MinorPerMajor"],
        activeItem: json["ActiveItem"],
        inStock: json["InStock"],
        groupCode: json["GroupCode"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "ProductCode": productCode,
        "ItemName": itemName,
        "ItemImage": itemImage,
        "ByWeight": byWeight,
        "vat": vat,
        "POSTP": postp,
        "POSPP": pospp,
        "MinorPerMajor": minorPerMajor,
        "ActiveItem": activeItem,
        "InStock": inStock,
        "GroupCode": groupCode,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
