import '../../../../app_export.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({super.key, this.isUser = false});
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    final local = context.loc;

    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        int index = state is NavigationInitial ? state.index : 0;

        final items = isUser ? [
          {'icon': Assets.icons.home, 'label': local.home},
          {'icon': Assets.icons.search, 'label': local.search},
          {'icon': Assets.icons.bookmarkGray, 'label': local.shortlisted},
          {'icon': Assets.icons.profileGray, 'label': local.profile},
        ] : [
          {'icon': Assets.icons.home, 'label': local.home},
          {'icon': Assets.icons.eventAdd, 'label': local.add_event},
          {'icon': Assets.icons.eventMy, 'label': local.my_event},
          {'icon': Assets.icons.profileGray, 'label': local.profile},
        ];

        return Container(
          decoration: const BoxDecoration(
            color: AppColors.backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, -1),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (i) {
                final selected = index == i;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => context.read<NavigationCubit>().changeIndex(index: i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.brandHoverColor.withValues(alpha: 0.15) : Colors.transparent,
                        border: Border(
                          top: BorderSide(
                            color: selected ? AppColors.brandHoverColor : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          (items[i]['icon'] as SvgGenImage).svg(
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            items[i]['label'] as String,
                            style: const TextStyle(
                              color: AppColors.brandHoverColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
