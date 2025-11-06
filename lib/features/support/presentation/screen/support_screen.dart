import 'package:event_listing_app/app_export.dart';
import 'package:flutter_easy_faq/flutter_easy_faq.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SupportCubit(
        apiClient: sl<IApiClient>(),
        db: sl<ILocalService>(),
      ),
      child: const _View(),
    );
  }
}

class _View extends StatefulWidget {
  const _View();

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.loc.helpSupport,
          style: context.titleMedium,
        ),
      ),
      body: BlocBuilder<SupportCubit, SupportState>(
        builder: (context, state) {
          if (state is OtherSupportState) {
            switch (state.status) {
              case ApiStatus.loading:
                return const LoadingWidget(color: AppColors.black,);

              case ApiStatus.internetError:
                return Center(
                  child: NoInternetCard(
                    onTap: () => context.read<SupportCubit>().get(),
                  ),
                );

              case ApiStatus.noDataFound:
                return Center(
                  child: Text(
                    context.loc.no_items_found,
                  ),
                );

              case ApiStatus.error:
                return ErrorCard(
                  onTap: () => context.read<SupportCubit>().get(),
                );

              case ApiStatus.completed:
                final items = state.faqModel.data ?? [];
                if (items.isEmpty) {
                  return Center(
                    child: Text(
                      context.loc.no_items_found,
                    ),
                  );
                }
                return CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index){
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, left: 18, right: 18),
                          child: EasyFaq(
                            backgroundColor: AppColors.softBrandColor,
                            questionTextStyle: context.titleSmall,
                            anserTextStyle: context.bodyMedium,
                            question: items[index].question ?? "",
                            answer: items[index].answer ?? "",
                          ),
                        );
                      }, childCount: items.length),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 44.0, left: 18, right: 18, top: 12),
                        child: Container(
                          width: context.width,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.softBrandColor,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Row(
                            spacing: 12,
                            children: [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: Assets.icons.support.svg(),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 5,
                                  children: [
                                    Text(context.loc.mailUs("support@PlayFinderUSA.com"), style: context.titleSmall.copyWith(fontSize: 12),),
                                    Text(context.loc.our_help_line_service_is_active)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
