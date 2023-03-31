
class Cars {
  String make;
  String modelName;
  String price;
  String bodyType;
  String safetyRating;
  String image;
  List<String> fuelType;
  String engine;
  String maxPower;
  String maxTorque;
  String mileage;
  List<String> sliderImages;

  Cars(
      this.make,
      this.modelName,
      this.price,
      this.bodyType,
      this.safetyRating,
      this.image,
      this.fuelType,
      this.engine,
      this.maxPower,
      this.maxTorque,
      this.mileage,
      this.sliderImages);
}

class Categories {
  String image;
  String textCategories;

  Categories(this.image, this.textCategories);
}

class BrandDetail {
  String image;
  String textBrand;

  BrandDetail(this.image, this.textBrand);
}

class CartModel {
  String productName;
  String productBrand;
  String productImage;
  String productPrice;
  int productQuantity;
  int productQuantityPrice;


  CartModel(this.productName, this.productBrand, this.productImage,
      this.productPrice, this.productQuantity,this.productQuantityPrice );

  Map<String, dynamic> toJson() => {
        'name': productName,
        'brand_name': productBrand,
        'image': productImage,
        'price': productPrice,
        'quantity': productQuantity,
        'quantityPrice' : productQuantityPrice,
      };

  CartModel.fromJson(Map<String, dynamic> jsonData)
  :  productName = jsonData['name'],
    productBrand = jsonData['brand_name'],
    productImage = jsonData['image'],
    productPrice = jsonData['price'],
    productQuantity = jsonData['quantity'],
        productQuantityPrice = jsonData['quantityPrice'];
}
