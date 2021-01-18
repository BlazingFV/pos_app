class Categories {
  String groupName;
  int byWeight;
  Categories({
    this.groupName,
    this.byWeight,
  });
  factory Categories.fromJson(map) {
    return Categories(
      byWeight: map['ByWeight'],
      groupName: map['GroupName'],
    );
  }
}
