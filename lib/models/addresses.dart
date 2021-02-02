class Addresses {
  final int id;
  final String buildingNo;
  final String rowNo;
  final String flatNo;
  final String street;
  final String remark;
  final bool main;
  final int areaNo;
  final int accSerial;
  final int phSerial;

  Addresses(
      {this.id,
      this.buildingNo,
      this.rowNo,
      this.flatNo,
      this.street,
      this.remark,
      this.main,
      this.areaNo,
      this.accSerial,
      this.phSerial});

  factory Addresses.fromJson(data) {
    return Addresses(
      id: data['id'] as int,
      buildingNo: data['BuildingNo'],
      rowNo: data['RowNo'],
      flatNo: data['FlatNo'],
      street: data['Street'],
      remark: data['remark'],
      main: data['main'],
      areaNo: data['AreaNo'],
      accSerial: data['AccSerial'],
      phSerial: data['PhSerial'],
    );
  }
}
