class BannerModel {
  String? image;

  BannerModel({
    this.image,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        image: json["image"] ?? "",
      );
}
