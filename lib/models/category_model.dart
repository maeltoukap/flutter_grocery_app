class CategoryModel {
  String? name;
  String? shortDescription;
  String? longDescription;
  String? primaryImage;
  List<String>? detailImages;
  String? id;
  String? status;
  String? createdAt;
  String? updatedAt;

  CategoryModel(
      {this.name,
      this.shortDescription,
      this.longDescription,
      this.primaryImage,
      this.detailImages,
      this.id,
      this.status,
      this.createdAt,
      this.updatedAt});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    primaryImage = json['primary_image'];
    detailImages = json['detail_images'].cast<String>();
    id = json['id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['short_description'] = shortDescription;
    data['long_description'] = longDescription;
    data['primary_image'] = primaryImage;
    data['detail_images'] = detailImages;
    data['id'] = id;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
