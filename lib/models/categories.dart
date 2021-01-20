class Categories {
  int id;
  String groupName;
  int byWeight;
  Categories({
    this.groupName,
    this.byWeight,
    this.id,
  });
  factory Categories.fromJson(map) {
    return Categories(
      byWeight: map['ByWeight'],
      groupName: map['GroupName'],
      id: map['id'],
    );
  }
}
