class MenuOption {
  final String name;
  final String nameVi;
  final String type;
  final double basePrice;
  final String imageUrl;

  const MenuOption(
      {required this.name,
      required this.nameVi,
      required this.type,
      required this.basePrice,
      required this.imageUrl});

  String getViType() {
    switch (type) {
      case "drink":
        return "Đồ uống";
      case "breakfast":
        return "Đồ ăn nhanh";
      default:
        return "";
    }
  }

  static const coffee = MenuOption(
      name: "Coffee",
      nameVi: "Cà phê",
      type: "drink",
      basePrice: 2,
      imageUrl:
          "https://minio.thecoffeehouse.com/image/admin/1639377798_ca-phe-den-da_400x400.jpg");
  static const milkTea = MenuOption(
      name: "Milk tea",
      nameVi: "Trà sữa",
      type: "drink",
      basePrice: 2.25,
      imageUrl:
          "https://minio.thecoffeehouse.com/image/admin/hong-tra-sua-tran-chau_326977_400x400.jpg");
  static const sandwich = MenuOption(
      name: "Sandwich",
      nameVi: "Bánh mì sandwich",
      type: "breakfast",
      basePrice: 3,
      imageUrl:
          "https://minio.thecoffeehouse.com/image/admin/1638440015_banh-mi-vietnam_400x400.jpg");
  static const bagel = MenuOption(
      name: "Bagel",
      nameVi: "Bánh vòng",
      type: "breakfast",
      basePrice: 3,
      imageUrl:
          "https://minio.thecoffeehouse.com/image/admin/1669736956_banh-mi-que-pate_400x400.png");
}

enum DrinkTypeOption {
  none(name: "not set", nameVi: "không", basePrice: 0),
  hot(name: "hot", nameVi: "nóng", basePrice: 0),
  cold(name: "cold", nameVi: "đá", basePrice: 0),
  blended(name: "blended", nameVi: "đá xay", basePrice: 1);

  const DrinkTypeOption(
      {required this.name, required this.nameVi, required this.basePrice});

  bool hasSize(DrinkSizeOption size) {
    return (name == "cold" ||
        name == "blended" ||
        size.name == "S" ||
        size.name == "M");
  }

  final String name;
  final String nameVi;
  final double basePrice;
}

enum DrinkSizeOption {
  none(name: "not set", nameVi: "không", basePrice: 0),
  s(name: "S", nameVi: "nhỏ", basePrice: 0),
  m(name: "M", nameVi: "vừa", basePrice: 0.5),
  l(name: "L", nameVi: "lớn", basePrice: 1),
  xl(name: "XL", nameVi: "rất lớn", basePrice: 1.5);

  const DrinkSizeOption(
      {required this.name, required this.nameVi, required this.basePrice});

  final String name;
  final String nameVi;
  final double basePrice;
}
