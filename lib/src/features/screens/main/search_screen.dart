import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/search_input.dart';
import '../../../core/service_locator/service_locator.dart';
import '../../../core/utils/app_context.dart';
import '../../mangers/main/cubit/main_cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<MainCubit>(),
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  SearchInput(
                    controller: controller,
                    hint: "Search",
                    onChanged: (value) =>
                        context.read<MainCubit>().search(value),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: ListView.separated(
                        itemBuilder: (context, index) => ListTile(
                          onTap: () {},
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                state.searchResult[index].imageUrl),
                          ),
                          title: Text(
                            state.searchResult[index].name,
                            style: context.textTheme.titleSmall,
                          ),
                          subtitle: Text(
                            state.searchResult[index].address,
                            style: context.textTheme.bodySmall,
                          ),
                        ),
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(
                            color: context.colors.outline,
                          ),
                        ),
                        itemCount: state.searchResult.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
