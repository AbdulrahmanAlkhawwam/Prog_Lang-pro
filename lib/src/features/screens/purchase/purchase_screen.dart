import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/components/skeleton.dart';
import '../../../features/models/purchase.dart';
import '../../../features/widgets/purchase/purchase_item.dart';
import '../../../core/utils/app_context.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: 'Completed'),
                  Tab(text: 'InCompleted'),
                ],
              ),
              Expanded(
                child: FutureBuilder(
                  future: to_get_response_from_api(),
                  builder: (context, snapshot) {
                    if (1 == 1) {
                      return TabBarView(
                        children: [
                          ListView.separated(
                            padding: EdgeInsets.symmetric(
                                horizontal: 36, vertical: 16),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return PurchaseItem(
                                purchase: Purchase(
                                  id: 123,
                                  name: "name",
                                  storeId: 123,
                                  price: 123.123,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 16);
                            },
                          ),
                        ],
                      );
                    } else {
                      return ListView.separated(
                        padding:
                            EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                        itemCount: 15,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(17),
                            height: 119,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: context.colors.surfaceContainer,
                            ),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      color: context.colors.onPrimaryContainer,
                                    ),
                                    SizedBox(height: 4),
                                    Icon(
                                      Icons.storefront,
                                      color: context.colors.onPrimaryContainer,
                                    ),
                                    SizedBox(height: 4),
                                    Icon(
                                      Icons.attach_money,
                                      color: context.colors.onPrimaryContainer,
                                    ),
                                  ],
                                ),
                                SizedBox(width: 12),
                                SizedBox(
                                  height: 119,
                                  width: 132,
                                  child: Shimmer.fromColors(
                                    //the shimmer color should edit
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Skeleton(
                                      lines: 3,
                                      height: 16,
                                      spacing: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 16);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//this temporary function to get response from api
to_get_response_from_api() {}
