import 'package:flutter/material.dart';
import 'package:program_language_project/src/core/utils/app_context.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/components/skeleton.dart';

class ShopDetailsScreen extends StatelessWidget {
  List<String> _tabs = [];

  ShopDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // --fromApi function-- is a test empty function that should return an object from shop class
        // and put the result in snapshot
        future: fromApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DefaultTabController(
              length: _tabs.length,
              child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(455),
                    child: AppBar(
                      flexibleSpace: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "")), //image should load from api
                              ),
                            ),
                          ),
                          Container(
                            height: 1.0,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: context.colors.outline,
                                  blurRadius: 4,
                                  offset: Offset(0, 3), // Shadow above
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "market name",
                                    //market name should load from api
                                    style: TextStyle(
                                      color: context.colors.onSurface,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 16),
                                    child: Text(
                                      "Market description Market description Market description",
                                      //market description from api
                                      style: TextStyle(
                                        color: context.colors.onSurface,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.map,
                                        color: context.colors.primaryContainer,
                                      ),
                                      SizedBox(width: 14),
                                      Text(
                                        "Market place",
                                        //market place should load from api
                                        style: TextStyle(
                                          color:
                                              context.colors.primaryContainer,
                                          fontSize: 14,
                                        ),
                                      ), //from api
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.door_front_door_outlined,
                                          color:
                                              context.colors.primaryContainer,
                                        ),
                                        SizedBox(width: 14),
                                        Text(
                                          "Market state",
                                          //Market state should load from api
                                          style: TextStyle(
                                            color:
                                                context.colors.primaryContainer,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.lens_blur,
                                        color: context.colors.primaryContainer,
                                      ),
                                      SizedBox(width: 14),
                                      Text(
                                        "Market category",
                                        //Market category should load from api
                                        style: TextStyle(
                                          color:
                                              context.colors.primaryContainer,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 1.0,
                            decoration: BoxDecoration(
                              color: context.colors.surface,
                              boxShadow: [
                                BoxShadow(
                                  color: context.colors.outline,
                                  blurRadius: 4,
                                  offset: Offset(0, -3), // Shadow above
                                ),
                              ],
                            ),
                          ),
                          TabBar(
                            padding: EdgeInsets.zero,
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: context.colors.onSurface,
                            unselectedLabelColor: context.colors.outline,
                            indicatorColor: context.colors.primary,
                            labelStyle: TextStyle(fontSize: 14),
                            tabs: _tabs.map((tap) {
                              return Tab(text: tap);
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: _tabs.map((tap) {
                      return Padding(
                        padding: EdgeInsets.only(left: 36, right: 36, top: 24),
                        child: ListView.separated(
                          itemCount:
                              10, //that should edit when connecting with api
                          itemBuilder: (context, index) {
                            return Container(
                                decoration: BoxDecoration(
                                    color: context.colors.surfaceContainer,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 140,
                                        height: 140,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Image.network(
                                            ""), //image that should load from api
                                      ),
                                      // SizedBox(width: 21),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 9, bottom: 22),
                                            child: Text(
                                              "product Name",
                                              //product name that should load from api
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: context.colors.onSurface,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.fastfood_outlined,
                                                color: context
                                                    .colors.primaryContainer,
                                              ),
                                              SizedBox(width: 14),
                                              Text(
                                                "product ingredients",
                                                //product ingredients that should load from api
                                                style: TextStyle(
                                                  color: context
                                                      .colors.primaryContainer,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 3),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .door_front_door_outlined,
                                                  color: context
                                                      .colors.primaryContainer,
                                                ),
                                                SizedBox(width: 14),
                                                Text(
                                                  "Market name",
                                                  //Market name that should load from api
                                                  style: TextStyle(
                                                    color: context.colors
                                                        .primaryContainer,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.attach_money,
                                                color: context
                                                    .colors.primaryContainer,
                                              ),
                                              SizedBox(width: 14),
                                              Text(
                                                "product price",
                                                //product price that should load from api
                                                style: TextStyle(
                                                  color: context
                                                      .colors.primaryContainer,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 12);
                          },
                        ),
                      );
                    }).toList(),
                  )),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("check internet connection"),
            );
          } else {
            return Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(455),
                  child: AppBar(
                    flexibleSpace: Column(
                      children: [
                        Expanded(
                          child: Shimmer.fromColors(
                              baseColor: context.colors.primaryContainer
                                  .withOpacity(0.75),
                              highlightColor:
                                  context.colors.surface.withOpacity(0.25),
                              child: Container(
                                color: Colors.white,
                              )),
                        ),
                        Container(
                          height: 1,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: context.colors.outline,
                                blurRadius: 4,
                                offset: Offset(0, 3), // Shadow above
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: context.colors.primaryContainer
                                      .withOpacity(0.75),
                                  highlightColor:
                                      context.colors.surface.withOpacity(0.25),
                                  child: Skeleton(
                                    height: 22,
                                    width: 200,
                                  ),
                                ),
                                Shimmer.fromColors(
                                  baseColor: context.colors.primaryContainer
                                      .withOpacity(0.75),
                                  highlightColor:
                                      context.colors.surface.withOpacity(0.25),
                                  child: Skeleton(
                                    lines: 2,
                                    spacing: 2,
                                    height: 12,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Shimmer.fromColors(
                                  baseColor: context.colors.primaryContainer
                                      .withOpacity(0.75),
                                  highlightColor:
                                      context.colors.surface.withOpacity(0.25),
                                  child: Skeleton(
                                    height: 14,
                                    lines: 3,
                                    spacing: 4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 1.0,
                          decoration: BoxDecoration(
                            color: context.colors.surface,
                            boxShadow: [
                              BoxShadow(
                                color: context.colors.outline,
                                blurRadius: 4,
                                offset: Offset(0, -3),
                              ),
                            ],
                          ),
                        ),
                        Shimmer.fromColors(
                            baseColor: context.colors.primaryContainer
                                .withOpacity(0.75),
                            highlightColor:
                                context.colors.surface.withOpacity(0.25),
                            child: Container(
                              width: 1000,
                              height: 50,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                ),
                body: Padding(
                  padding: EdgeInsets.only(left: 36, right: 36, top: 24),
                  child: ListView.separated(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor:
                            context.colors.primaryContainer.withOpacity(0.75),
                        highlightColor:
                            context.colors.surface.withOpacity(0.25),
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                              color: context.colors.surfaceContainer,
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 12);
                    },
                  ),
                ));
          }
        });
  }
}

fromApi() {}
