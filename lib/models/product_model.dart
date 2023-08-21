class ProductModel {
  Null? bulkDeals;
  SingleDeal? singleDeal;
  GroupDeal? groupDeal;
  String? shortDescription;
  String? longDescription;
  String? primaryImage;
  List<String>? detailImages;
  List<String>? tags;
  String? id;
  String? productStatus;
  String? name;
  String? measuringUnit;
  int? groupCount;
  String? discount;
  bool? favorite;
  String? vendorId;
  String? categoryId;
  String? createdAt;
  String? updatedAt;

  ProductModel(
      {this.bulkDeals,
      this.singleDeal,
      this.groupDeal,
      this.shortDescription,
      this.longDescription,
      this.primaryImage,
      this.detailImages,
      this.tags,
      this.id,
      this.productStatus,
      this.name,
      this.measuringUnit,
      this.groupCount,
      this.discount,
      this.favorite,
      this.vendorId,
      this.categoryId,
      this.createdAt,
      this.updatedAt});

  ProductModel.fromJson(Map<String, dynamic> json) {
    bulkDeals = json['bulk_deals'];
    singleDeal = json['single_deal'] != null
        ? new SingleDeal.fromJson(json['single_deal'])
        : null;
    groupDeal = json['group_deal'] != null
        ? new GroupDeal.fromJson(json['group_deal'])
        : null;
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    primaryImage = json['primary_image'];
    detailImages = json['detail_images'].cast<String>();
    tags = json['tags'].cast<String>();
    id = json['id'];
    productStatus = json['product_status'];
    name = json['name'];
    measuringUnit = json['measuring_unit'];
    groupCount = json['group_count'];
    discount = json['discount'];
    favorite = json['favorite'];
    vendorId = json['vendor_id'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bulk_deals'] = this.bulkDeals;
    if (this.singleDeal != null) {
      data['single_deal'] = this.singleDeal!.toJson();
    }
    if (this.groupDeal != null) {
      data['group_deal'] = this.groupDeal!.toJson();
    }
    data['short_description'] = this.shortDescription;
    data['long_description'] = this.longDescription;
    data['primary_image'] = this.primaryImage;
    data['detail_images'] = this.detailImages;
    data['tags'] = this.tags;
    data['id'] = this.id;
    data['product_status'] = this.productStatus;
    data['name'] = this.name;
    data['measuring_unit'] = this.measuringUnit;
    data['group_count'] = this.groupCount;
    data['discount'] = this.discount;
    data['favorite'] = this.favorite;
    data['vendor_id'] = this.vendorId;
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SingleDeal {
  String? originalPrice;
  int? availableQuantity;
  String? id;

  SingleDeal({this.originalPrice, this.availableQuantity, this.id});

  SingleDeal.fromJson(Map<String, dynamic> json) {
    originalPrice = json['original_price'];
    availableQuantity = json['available_quantity'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['original_price'] = originalPrice;
    data['available_quantity'] = availableQuantity;
    data['id'] = id;
    return data;
  }
}

class GroupDeal {
  String? groupPrice;
  int? maxGroupMember;
  int? expirationTime;
  String? id;

  GroupDeal(
      {this.groupPrice, this.maxGroupMember, this.expirationTime, this.id});

  GroupDeal.fromJson(Map<String, dynamic> json) {
    groupPrice = json['group_price'];
    maxGroupMember = json['max_group_member'];
    expirationTime = json['expiration_time'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group_price'] = groupPrice;
    data['max_group_member'] = maxGroupMember;
    data['expiration_time'] = expirationTime;
    data['id'] = id;
    return data;
  }
}
