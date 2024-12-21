import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/app_context.dart';
import '../../mangers/shops/shops_bloc.dart';



class ShopDetailsScreen extends StatelessWidget {

  List<String> _tabs = [];

  ShopDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopsBloc, ShopsState>(
      builder: (context, state) {
        switch (state.status) {
          case ShopsStatus.loading:
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          case ShopsStatus.error:
            return Scaffold(
              body: Center(child: Text('Error loading details : #${state.message.toString()}')),
            );
          case ShopsStatus.success:

            final shop = state.shops?.first;

            return Scaffold(
              body: Column(
                children: [
                  // Container for image
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            '''http://127.0.0.1:8000/${shop?.imageUrl ?? ""}''',
                          ),
                          fit: BoxFit.cover, // Added fit property for better display
                        ),
                      ),
                    ),
                  ),
                  // Container with shadow separator
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: context.colors.outline,
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                  // Main content container
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            shop?.name ?? "marketname",
                            style: TextStyle(
                              color: context.colors.onSurface,
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 4, bottom: 16),
                            child: Text(
                              shop?.description ?? "Market description",
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
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.door_front_door_outlined,
                                  color: context.colors.primaryContainer,
                                ),
                                SizedBox(width: 14),
                                Text(
                                  shop?.status ?? "Market state",
                                  style: TextStyle(
                                    color: context.colors.primaryContainer,
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
                                style: TextStyle(
                                  color: context.colors.primaryContainer,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Final container for separation
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
                ],
              ),
            );

          case ShopsStatus.init:
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
        }
      },
    );
  }
}