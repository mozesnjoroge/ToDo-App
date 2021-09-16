class Category {
  int? id;
  String? name;
  String? description;

  categoryMap() {
    var dataMap = Map<String, dynamic>();
    dataMap['id'] = id;
    dataMap['name'] = name;
    dataMap['description'] = description;

    return dataMap;
  }
}
