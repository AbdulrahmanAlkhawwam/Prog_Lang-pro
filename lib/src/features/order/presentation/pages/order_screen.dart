import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/screens/empty_orders_screen.dart';
import '../../../../core/components/screens/error_screen.dart';
import '../../domain/entities/order.dart';
import '../manger/order_bloc.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return switch (state.status) {
          OrderStatus.error => ErrorScreen(errorMessage: state.message!),
          _ => DefaultTabController(
              length: 3,
              child: Scaffold(
                body: SafeArea(
                  child: Column(
                    children: [
                      TabBar(
                        tabs: [
                          Tab(text: 'Completed'),
                          Tab(text: 'InCompleted'),
                          Tab(text: 'Canceled'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            state.completedOrders.isEmpty &&
                                    state.status == OrderStatus.success
                                ? EmptyOrdersScreen()
                                : ListView.separated(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    itemCount:
                                        state.status != OrderStatus.success
                                            ? 7
                                            : state.completedOrders.length,
                                    itemBuilder: (context, index) {
                                      return PurchaseItem(
                                          isLoading: state.status !=
                                              OrderStatus.success,
                                          order: state.status !=
                                                  OrderStatus.success
                                              ? Order(
                                                  id: 0,
                                                  status: '',
                                                  price: 0.0,
                                                  createdAt: DateTime.now(),
                                                  updatedAt: DateTime.now(),
                                                )
                                              : state.completedOrders[index]);
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 16),
                                  ),
                            state.inCompletedOrders.isEmpty &&
                                    state.status == OrderStatus.success
                                ? EmptyOrdersScreen()
                                : ListView.separated(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    itemCount:
                                        state.status != OrderStatus.success
                                            ? 3
                                            : state.inCompletedOrders.length,
                                    itemBuilder: (context, index) {
                                      return PurchaseItem(
                                          isLoading: state.status !=
                                              OrderStatus.success,
                                          order: state.status !=
                                                  OrderStatus.success
                                              ? Order(
                                                  id: 0,
                                                  status: '',
                                                  price: 0.0,
                                                  createdAt: DateTime.now(),
                                                  updatedAt: DateTime.now(),
                                                )
                                              : state.inCompletedOrders[index]);
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 16),
                                  ),
                            state.canceledOrders.isEmpty &&
                                    state.status == OrderStatus.success
                                ? EmptyOrdersScreen()
                                : ListView.separated(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    itemCount:
                                        state.status != OrderStatus.success
                                            ? 5
                                            : state.canceledOrders.length,
                                    itemBuilder: (context, index) {
                                      return PurchaseItem(
                                          isLoading: state.status !=
                                              OrderStatus.success,
                                          order: state.status !=
                                                  OrderStatus.success
                                              ? Order(
                                                  id: 0,
                                                  status: '',
                                                  price: 0.0,
                                                  createdAt: DateTime.now(),
                                                  updatedAt: DateTime.now(),
                                                )
                                              : state.canceledOrders[index]);
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 16),
                                  ),
                          ],
                        ),
                        // return ListView.separated(
                        // padding: EdgeInsets.symmetric(
                        // horizontal: 36, vertical: 16),
                        // itemCount: 15,
                        // itemBuilder: (context, index) {
                        // return Container(
                        // padding: EdgeInsets.all(17),
                        // height: 119,
                        // decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(12),
                        // color: context.colors.surfaceContainer,
                        // ),
                        // child: Row(
                        // children: [
                        // Column(
                        // mainAxisAlignment:
                        // MainAxisAlignment.center,
                        // children: [
                        // Icon(
                        // Icons.calendar_month_outlined,
                        // color: context
                        //     .colors.onPrimaryContainer,
                        // ),
                        // SizedBox(height: 4),
                        // Icon(
                        // Icons.storefront,
                        // color: context
                        //     .colors.onPrimaryContainer,
                        // ),
                        // SizedBox(height: 4),
                        // Icon(
                        // Icons.attach_money,
                        // color: context
                        //     .colors.onPrimaryContainer,
                        // ),
                        // ],
                        // ),
                        // SizedBox(width: 12),
                        // SizedBox(
                        // height: 119,
                        // width: 132,

                        // ),
                        // ],
                        // ),
                        // );
                        // },
                        // separatorBuilder: (context, index) {
                        // return SizedBox(height: 16);
                        // },
                        // );
                      ),
                    ],
                  ),
                ),
              ),
            ),
        };
      },
    );
  }
}
