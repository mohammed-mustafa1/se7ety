import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/extensions/navigation.dart';
import 'package:se7ety/core/routers/app_routers.dart';
import 'package:se7ety/features/patient/home/presentation/pages/search_screen.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/specialization_list_view_item.dart';

class SpecializationListView extends StatelessWidget {
  const SpecializationListView({super.key, required this.items});
  final List items;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: items.length,

      separatorBuilder: (context, index) => Gap(16),
      itemBuilder:
          (context, index) => GestureDetector(
            onTap: () {
              context.pushTo(
                AppRouter.search,
                extra: [items[index], SearchType.specialization],
              );
            },
            child: SpecializationListViewItem(
              text: items[index],
              backgroundColor: Colors.primaries[index].shade300,
            ),
          ),
    );
  }
}
