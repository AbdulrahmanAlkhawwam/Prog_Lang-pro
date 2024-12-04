import 'package:flutter/material.dart';

import '../../models/Location.dart';
import '../../models/category.dart';
import '../../models/shop.dart';
import 'shops_item.dart';

class ShopsList extends StatelessWidget {
  const ShopsList({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO : clear demo data
    final shops = [
      Shop(
        id: "12345566",
        name: "al sultan",
        place: Location(
          latitudes: 0000.0000,
          longitudes: 0000.000,
        ),
        status: "OPENED",
        // imageId: "/",
        category: Category(
          id: "1234567",
          iconId: 1234,
          categoryName: "FOOD",
        ),
      ),
      Shop(
        id: "12345566",
        name: "al sultan",
        place: Location(
          latitudes: 0000.0000,
          longitudes: 0000.000,
        ),
        status: "OPENED",
        // imageId: "kfjv31242oef",
        category: Category(
          id: "1234567",
          iconId: 1234,
          categoryName: "FOOD",
        ),
      ),
      Shop(
        id: "12345566",
        name: "al sultan",
        place: Location(
          latitudes: 0000.0000,
          longitudes: 0000.000,
        ),
        status: "OPENED",
        // imageId: "kfjv31242oef",
        category: Category(
          id: "1234567",
          iconId: 1234,
          categoryName: "FOOD",
        ),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: GridView.builder(
        itemCount: shops.length,
        itemBuilder: (context, index) => ShopsItem(
          shop: shops[index],
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
      ),
    );
  }
}
