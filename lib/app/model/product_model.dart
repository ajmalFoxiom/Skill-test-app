class Product {
  int? id;
  bool? inWishlist;
  int? avgRating;
  int? salePrice;
  bool? available;
  String? availableFrom;
  String? availableTo;
  String? name;
  String? featuredImage;
  int? mrp;
  String? discount;
  String? createdDate;

  Product({
    this.id,
    this.inWishlist,
    this.avgRating,
    this.salePrice,
    this.available,
    this.availableFrom,
    this.availableTo,
    this.name,
    this.featuredImage,
    this.mrp,
    this.discount,
    this.createdDate,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inWishlist = json['in_wishlist'];
    avgRating = json['avg_rating'];

    salePrice = json['sale_price'];

    available = json['available'];
    availableFrom = json['available_from'];
    availableTo = json['available_to'];
    name = json['name'];

    featuredImage = json['featured_image'];
    mrp = json['mrp'];

    discount = json['discount'];
    createdDate = json['created_date'];
  }
}
