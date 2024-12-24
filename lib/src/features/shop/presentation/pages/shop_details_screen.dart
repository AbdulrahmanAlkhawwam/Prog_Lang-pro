import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:program_language_project/src/features/home/presentation/manger/cubit/main_cubit.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/app_context.dart';
import '../manger/shop_bloc.dart';

class ShopDetailsScreen extends StatelessWidget {
  // List<String> _tabs = [];
  final int id;

  const ShopDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<ShopBloc>()..add(GetShopsDetails(id: id)),
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          switch (state.status) {
            case ShopStatus.loading:
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case ShopStatus.error:
              return Scaffold(
                body: Center(
                    child: Text(
                        'Error loading details : #${state.message.toString()}')),
              );
            case ShopStatus.success:
              return Scaffold(
                body: Column(
                  children: [
                    // Container for image
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(context
                                .read<MainCubit>()
                                .image(state.shop!.imagePath)),
                            fit: BoxFit
                                .cover, // Added fit property for better display
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.shop?.name ?? "marketname",
                              style: TextStyle(
                                color: context.colors.onSurface,
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 4, bottom: 16),
                              child: Text(
                                state.shop?.description ?? "Market description",
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
                                    state.shop?.status ?? "Market state",
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

            case ShopStatus.init:
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
          }
        },
      ),
    );
  }
}
