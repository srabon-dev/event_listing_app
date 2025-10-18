import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../app_export.dart';

class TermsOfCondition extends StatelessWidget {
  const TermsOfCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TermsCubit(
        apiClient: sl<IApiClient>(),
        db: sl<ILocalService>(),
      ),
      child: const _TermsView(),
    );
  }
}

class _TermsView extends StatelessWidget {
  const _TermsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.loc.termsConditions,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: BlocBuilder<TermsCubit, TermsState>(
        builder: (context, state) {
          if (state is OtherTermsState) {
            switch (state.status) {
              case ApiStatus.loading:
                return const LoadingWidget(color: AppColors.black,);

              case ApiStatus.internetError:
                return Center(
                  child: NoInternetCard(
                    onTap: () => context.read<TermsCubit>().getTerms(),
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
                  onTap: () => context.read<TermsCubit>().getTerms(),
                );

              case ApiStatus.completed:
                final description = state.description.trim();
                if (description.isEmpty) {
                  return Center(
                    child: Text(
                      context.loc.no_items_found,
                    ),
                  );
                }
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: HtmlWidget(description),
                );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
