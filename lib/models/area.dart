class Area {
  int id;
  String areaName;
  var deliveryServiceTotal;
  var postalCode;
  var avilableFrom;
  var avilableTo;
  var apply;
  Area({
    this.id,
    this.areaName,
    this.deliveryServiceTotal,
    this.apply,
    this.avilableFrom,
    this.avilableTo,
    this.postalCode,
  });
  factory Area.fromJson(data) {
    return Area(
      id: data['id'],
      apply: data['Apply'],
      areaName: data['AreaName'],
      avilableFrom: data['AvilableFrom'],
      avilableTo: data['AvilableTo'],
      deliveryServiceTotal: data['DeliveryServiceTotal'],
      postalCode: data['PostalCode'],
    );
  }
}
