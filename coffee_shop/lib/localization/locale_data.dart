import 'package:get/get.dart';

class AppMessages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": {
          "all_items": "All items",
          "drink": "Drink",
          "breakfast": "Breakfast",
          "drawer_header": "Menu categories",
        },
        "vi_VN": {
          "all_items": "Tất cả",
          "drink": "Đồ uống",
          "breakfast": "Bánh & Snack",
          "drawer_header": "Nhóm sản phẩm",
        }
      };
}
