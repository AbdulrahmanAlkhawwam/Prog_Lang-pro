import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/screens/empty_orders_screen.dart';
import '../../../../core/components/screens/error_screen.dart';
import '../../../../core/localization/keys.g.dart';
import '../../domain/entities/order.dart';
import '../manger/order_bloc.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final _tabs = [
    Tab(text: LocaleKeys.order_tabs_completed.tr()),
    Tab(text: LocaleKeys.order_tabs_unComplete.tr()),
    Tab(text: LocaleKeys.order_tabs_canceled.tr()),
  ];

  Future<void> _refresh() async {
    _refreshIndicatorKey.currentState?.show();
    context.read<OrderBloc>().add(GetOrders());
    await Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) => switch (state.status) {
        OrderStatus.error => ErrorScreen(errorMessage: state.message!),
        OrderStatus.loading || OrderStatus.init => DefaultTabController(
            length: _tabs.length,
            child: Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    TabBar(tabs: _tabs),
                    Expanded(
                      child: TabBarView(
                        children: List.generate(
                          _tabs.length,
                          (index) => ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            itemCount: 7,
                            itemBuilder: (context, index) => PurchaseItem(
                              isLoading: true,
                              order: Order(
                                id: 0,
                                status: '',
                                price: 0.0,
                                createdAt: DateTime.now(),
                                updatedAt: DateTime.now(),
                              ),
                            ),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        _ => DefaultTabController(
            length: _tabs.length,
            child: Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    TabBar(tabs: _tabs),
                    Expanded(
                      child: TabBarView(
                        children: List.generate(
                          _tabs.length,
                          (tab) => RefreshIndicator(
                            onRefresh: _refresh,
                            child: switch (tab) {
                              0 => state.completedOrders.isEmpty,
                              1 => state.inCompletedOrders.isEmpty,
                              _ => state.canceledOrders.isEmpty
                            }
                                ? EmptyOrdersScreen(onRefresh: _refresh)
                                : ListView.separated(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    itemCount: switch (tab) {
                                      0 => state.completedOrders.length,
                                      1 => state.inCompletedOrders.length,
                                      _ => state.canceledOrders.length
                                    },
                                    itemBuilder: (context, index) =>
                                        PurchaseItem(
                                      isLoading: false,
                                      order: switch (tab) {
                                        0 => state.completedOrders[index],
                                        1 => state.inCompletedOrders[index],
                                        _ => state.canceledOrders[index]
                                      },
                                    ),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 16),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      },
    );
  }
}
